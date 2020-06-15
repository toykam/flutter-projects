import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodclip/utils/constants.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddDispatchNotifier extends ChangeNotifier {
  bool isLoading = true;
  TextEditingController _street = TextEditingController();
  String _latitude;
  String _chLatitude;
  String _longitude;
  String _chLongitude;
  String _lcd;
  TextEditingController _houseHoldName = TextEditingController();
  String _dispatch_by = '';
  TextEditingController _package = TextEditingController();
  TextEditingController _houseName = TextEditingController();
  bool _isGettingLocation = true;
  String locationStatus = '';

  set _setLoading(bool status) {
    isLoading = status;
    notifyListeners();
  }

  set setLocationStatus(String status) {
    locationStatus = status;
    notifyListeners();
  }

  set setIsGettingLocation(bool status) {
    _isGettingLocation = status;
    notifyListeners();
  }

  set setLcd(String lcd) {
    _lcd = lcd;
    notifyListeners();
  }

  set setPackage(String package) {
    _package.text = package;
    notifyListeners();
  }

  set setHouseHold(String houseHold) {
    _houseHoldName.text = houseHold;
    notifyListeners();
  }

  set setHouseName(String houseName) {
    _houseName.text = houseName;
    notifyListeners();
  }

  set _setStreet(String street) {
    _street.text = street;
    notifyListeners();
  }

  set _setLat(String latitude) {
    _latitude = latitude;
  }

  set _setLng(String longitude) {
    _longitude = longitude;
  }

  set _setChLat(String latitude) {
    _chLatitude = latitude;
  }

  set _setChLng(String longitude) {
    _chLongitude = longitude;
  }

  String get getLcd => _lcd;
  String get getLocationStatus => locationStatus;
  TextEditingController get getHouseHoldName => _houseHoldName;
  TextEditingController get getHouseName => _houseName;
  String get getLat => _latitude;
  String get getLng => _longitude;
  TextEditingController get getStreet => _street;
  TextEditingController get getPackage => _package;
  bool get getIsGettingLocation => _isGettingLocation;
  StreamSubscription locationListener;

  void initialize() async {
    isLoading = true;
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    _dispatch_by = _sharedPref.getString(USER_ID_KEY);
    getLocation();
    isLoading = false;
    notifyListeners();
  }

  void addNewDispatch(context) async {
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    _setLoading = true;
    captureLatnLng();
    if (_latitude == null && _longitude == null) {
      setLocationStatus = 'Please turn on your location';
      getLocation();
    } else {
      setLocationStatus = '';
      var msg = '';
      var dispatchData = {
        "street_name" : _street.text == null ? '' : _street.text,
        "house_name" : _houseName.text,
        "longitude": _longitude,
        "latitude": _latitude,
        "lcda": _lcd,
        "household": _houseHoldName.text,
        "dispatched_by": _dispatch_by,
        "packages": _package.text
      };
      print(dispatchData);
      if (_lcd == '' || _lcd == null) {
        msg = 'Please select a Gocal Government';
      } else {
        try {
          http.Response response = await http.post(
            SERVER_BASE_URL+'volunteer',
            body: dispatchData
          );
          // print('Dispatch Data: '+dispatchData.toString());
          if (response.statusCode == 200) {
            var res = json.decode(response.body);
            // print(res);
            msg = res['message'];
            _sharedPref.setString(USER_DISPATCHES_KEY, res['data']);
            clearFields();
          } else if (response.statusCode == 404) {
            var res = json.decode(response.body);
            msg = res['message'];
          } else {
            msg = response.body;
          }
        } catch(error) {
        // print(error);
          msg = 'Http Error: '+error.toString();
        }
      }
      
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Message'),
            content: SingleChildScrollView(
              child: Container(
                child: Text(msg.toString())
              ),
            ),
          );
        }
      );
    }
    _setLoading = false;
    notifyListeners();
  }

  void getLocation() async {
    setIsGettingLocation = true;
    print('Getting Location...');
    try {
      // Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

      Stream<Position> pos = Geolocator().getPositionStream();
      print(pos);
      locationListener = pos.listen((Position position) async {
        print(position);
        print('location: ${position.latitude}');
        print('location: ${position.longitude}');
        // _setStreet = position.latitude.toString();
        final coordinates = new Coordinates(position.latitude, position.longitude);
        var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
        var first = addresses.first;
        _setStreet = first.addressLine;
        _setChLat = position.latitude.toString();
        _setChLng = position.longitude.toString();
        setIsGettingLocation = false;
      });
      locationListener.onError((error) => setLocationStatus = 'Location Error! Please make sure to turn on your location');
    } catch(error) {
      print(error);
      setIsGettingLocation = false;
    } finally {
      setIsGettingLocation = false;
      notifyListeners();
    }
  }

  void clearFields() {
    setHouseHold = '';
    setHouseName = '';
    setPackage = '1';
    setLcd = null;
    _setLat = null;
    _setLng = null;
    // print(_latitude+" latitude");
    // print(_longitude+' Longitude');
    notifyListeners();
  }

  AddDispatchNotifier() {
    initialize();
  }

  void captureLatnLng() {
    _setLat = _chLatitude;
    _setLng = _chLongitude;
  }
}