import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/ui/home/common_widget.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

// ignore: must_be_immutable
class BloggerWebView extends StatelessWidget {
  BloggerWebView({this.content});
  String content;

  @override
  Widget build(BuildContext context) {
    var strToday = getStrToday();
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF1F5F9),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                ),
              ),
              padding: EdgeInsets.only(
                top: 16.0,
                bottom: 16.0,
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      WidgetTitle(strToday),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Builder(builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: HtmlWidget(content),
                        ),
                      ),
                    );
                  }),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.0),
                                  topLeft: Radius.circular(20.0))),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: TextField(
                                maxLines: 2,
                                decoration: InputDecoration(
                                    hintText: 'Comment here',
                                    contentPadding: const EdgeInsets.all(8.0)),
                              )),
                              IconButton(
                                  icon: Icon(Icons.send), onPressed: null)
                            ],
                          )))
                ],
              ),
            ),
          ],
        ),
      ),
//      floatingActionButton: FloatingActionButton(
//        child: Text('Comments'),
//        onPressed: null,
//
//      ),
    );
  }
}
