import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// WWW.IDRISSOLUTION.COM
class WebPage extends StatefulWidget {
  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  bool stillLoading = true;
  WebViewController _webController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stillLoading = true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async => await scopeWillPop(context, _webController),
          child: Stack(
            children: [
              (stillLoading) ? 
                Container(
                  color: Colors.green.withOpacity(0.3),
                  child: Center(child: CircularProgressIndicator(),),
                )
              : Container(),
              
              Builder(builder: (BuildContext context) {
                return WebView(
                  initialUrl: 'https://www.idrissolution.com',
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                    setState(() {
                      _webController = webViewController;
                    });
                  },
                  navigationDelegate: (NavigationRequest request) {
                    // print(request)
                    setState(() {
                      stillLoading = true;
                    });
                    return NavigationDecision.navigate;
                  },
                  onPageStarted: (String url) {
                    print('Page started loading: $url');
                    setState(() {
                      stillLoading = true;
                    });
                  },
                  onPageFinished: (String url) {
                    print('Page finished loading: $url');
                    setState(() {
                      stillLoading = false;
                    });
                  },
                  gestureNavigationEnabled: true,
                );
              }),
            ]
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _webController.reload();
        }, 
        child: Icon(Icons.refresh)
      ),
    );
  }
}



Future<bool> scopeWillPop(BuildContext context, WebViewController webController) async {
  // webController.
  bool canClose = false;
  if (await webController.canGoBack()) {
    await webController.goBack();
    return true;
    // canClose = false;
  } else {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Message'),
        content: Container(
          height: 100,
          child: Column(
            children: [
              Text('Do you want to close the App?'),
              SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.red.shade200,
                    onPressed: () {
                      canClose = true;
                      Navigator.pop(context);
                    }, 
                    child: Text('Yes')
                  ),
                  RaisedButton(
                    color: Colors.green.shade200,
                    onPressed: () {
                      canClose = false;
                      Navigator.pop(context);
                    },
                    child: Text('No')
                  ),
                ],
              ),
            ]
          ),
        ),
      )
    );
  }
  return canClose;
}