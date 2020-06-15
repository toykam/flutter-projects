import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  Animation animation, delayed;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(parent: animationController, curve: Curves.fastLinearToSlowEaseIn));
    delayed = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(parent: animationController, curve: Interval(0.8, 1.0, curve: Curves.fastLinearToSlowEaseIn)));
    // Control the animation to start with its controller
    animationController.forward();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: animation, 
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Colors.redAccent,
          body: Center(
            child: Container(
              // color: Colors.purple,
              margin: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Transform.translate(
                      offset: Offset(0.4, 0.8),
                      // angle: 180,
                      // transform: Matrix4.translationValues(animation.value *width, animation.value * height, 0.0),
                      child: Text('Login', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w200), textAlign: TextAlign.start,),
                    ),
                    SizedBox(height: 20),
                    Transform(
                      transform: Matrix4.translationValues(delayed.value *width, delayed.value * height, 0.0),
                      child: Material(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        elevation: 2,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Email',
                                enabledBorder: UnderlineInputBorder(),
                                alignLabelWithHint: true,
                                labelText: 'Email',
                              )
                            ),
                          ),
                        ),
                      ),
                    ),
                    Transform(
                      transform: Matrix4.translationValues(delayed.value *width, delayed.value * height, 0.0),
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Password',
                              border: OutlineInputBorder(),
                              enabledBorder: UnderlineInputBorder(),
                              alignLabelWithHint: true,
                              labelText: 'Password',
                            )
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ),
        );
      }
    );
  }
}
