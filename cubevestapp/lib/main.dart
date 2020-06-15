import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_web/flutter_native_web.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  WebController webController;
  bool _loading;

  @override
  initState() {
    super.initState();
    _loading = true;
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeWeb flutterWebView = FlutterNativeWeb(
      onWebCreated: onWebCreated,
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
        Factory<OneSequenceGestureRecognizer>(
          () => TapGestureRecognizer(),
        ),
      ].toSet(),
    );
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Visibility(
                  child: LinearProgressIndicator(),
                  visible: _loading,
                ),
                Container(
                  child: flutterWebView,
                  height: 1000.0,
                  width: 500.0,
                ),
              ],
            ),
          )
        ),
      ),
    );
  }

  void onWebCreated(webController) {
    this.webController = webController;
    this.webController.loadUrl("https://cubevest.com:3000");
    this.webController.onPageStarted.listen((url) {
      print("Loading $url");
      setState(() => _loading = true);
    });
    this.webController.onPageFinished.listen((url) {
      setState(() => _loading = false);
      print("Finished loading $url");
    });
    // this.webController.on
  }
}