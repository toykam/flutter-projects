import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

// ignore: must_be_immutable
class BloggerWebViewTwo extends StatefulWidget {
  BloggerWebViewTwo({this.url});
  String url;

  @override
  _BloggerWebViewTwoState createState() => _BloggerWebViewTwoState();
}

class _BloggerWebViewTwoState extends State<BloggerWebViewTwo> {
  bool _isLoading = true;
  String content = '';

  void loadUrl() async {
    try {
      await Dio().get(widget.url).then((onValue) {
        setState(() {
          content = onValue.data;
          _isLoading = false;
        });
        print('Downloaded Page: ' + onValue.toString());
      }).catchError((error) => print('Catched Error: ' + error.toString()));
    } on DioError catch (error) {
      print('Api Error: ' + error.toString());
    }
  }

  @override
  void initState() {
    loadUrl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: <Widget>[
          Builder(builder: (BuildContext context) {
            return SingleChildScrollView(
              child: HtmlWidget(content),
            );
          }),
          _isLoading
              ? Container(
                  color: Colors.black.withOpacity(0.3),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container()
        ],
      ),
    ));
  }
}
