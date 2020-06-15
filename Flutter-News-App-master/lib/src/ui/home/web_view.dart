import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/ui/home/common_widget.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class MyWebView extends StatefulWidget {
  MyWebView({this.url});
  String url;

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<MyWebView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    var strToday = getStrToday();
//    var mediaQuery = MediaQuery.of(context);
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      WidgetTitle(strToday),
                      Row(
                        children: <Widget>[
                          IconButton(
                              iconSize: 15,
                              icon: Icon(Icons.share),
                              onPressed: () => Share.share(
                                  'Check out the latest news: ' + widget.url)),
                          IconButton(
                              iconSize: 15,
                              icon: Icon(Icons.comment),
                              onPressed: () => Share.share(
                                  'Check out the latest news: ' + widget.url)),
                        ],
                      ),
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
                        height: 600,
                        child: Center(
                          child: WebView(
//                            initialUrl: 'http://toykam-dailytok.blogspot.com',
                            initialUrl: widget.url,
                            javascriptMode: JavascriptMode.unrestricted,
                            onWebViewCreated:
                                (WebViewController webViewController) {
                              _controller.complete(webViewController);
                            },
                            navigationDelegate: (NavigationRequest request) {
                              if (request.url
                                  .startsWith('https://www.youtube.com/')) {
                                print('blocking navigation to $request}');
                                return NavigationDecision.prevent;
                              }
                              print('allowing navigation to $request');
                              return NavigationDecision.navigate;
                            },
                            onPageStarted: (String url) {
                              print('Page started loading: $url');
                            },
                            onPageFinished: (String url) async {
                              print('Page finished loading: $url');
                              await Future.delayed(Duration(seconds: 5));
                              setState(() {
                                isLoading = false;
                              });
                            },
                            gestureNavigationEnabled: true,
                          ),
                        ),
                      ),
                    );
                  }),
                  isLoading
                      ? Container(
                          color: Colors.black.withOpacity(0.3),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ))
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
