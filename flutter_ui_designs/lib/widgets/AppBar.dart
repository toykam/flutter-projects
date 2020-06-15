import 'dart:async';

import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget {
  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {

  var time;
  var date;
  DateTime dateTime = new DateTime.now();

  Timer timer;
  List<String> imageAssets = [
    'assets/images/img.jpg',
    'assets/images/img1.jpg',
    'assets/images/img2.jpg',
  ];
  String currentImagePath;
  int currentImageIndex = 0;

  void changeCurrentImage() {
    
    if ((currentImageIndex + 1) == imageAssets.length) {
      setState(() {
        currentImageIndex = 0;
        currentImagePath = imageAssets[currentImageIndex];
        time = TimeOfDay.now().format(context).toString();
        date = dateTime.day.toString()+'/'+dateTime.month.toString()+'/'+dateTime.year.toString();
      });
    } else {
      setState(() {
        currentImageIndex += 1;
        currentImagePath = imageAssets[currentImageIndex];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentImagePath = imageAssets[currentImageIndex];
    time = TimeOfDay.now().format(context).toString();
    date = dateTime.day.toString()+'/'+dateTime.month.toString()+'/'+dateTime.year.toString();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => changeCurrentImage());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        backgroundBlendMode: BlendMode.darken,
        image: DecorationImage(
          image: AssetImage(currentImagePath),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.linearToSrgbGamma()
        )
      ),
      width: MediaQuery.of(context).size.width,
      height: (MediaQuery.of(context).size.height * 40) / 100,
      child: Column(
        children: [
          Padding(
            child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.menu, size: 30,), onPressed: () {},),
                Expanded(child: Text('Muslim App', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)),
                IconButton(icon: Icon(Icons.settings, size: 30,), onPressed: () {},),
              ],
            ), padding: const EdgeInsets.all(8.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child:   ListTile(
                      title: Text(date),
                      subtitle: Text(time),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    child: Center(
                      child: ListTile(
                        title: Text('Fajr', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500), textAlign: TextAlign.center,),
                        subtitle: Text('21:00', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500), textAlign: TextAlign.center,),
                      ),
                    )
                  )
                ),
              )
            ],
          ),
        ]
      ),
    );
  }
}