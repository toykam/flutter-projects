import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_ui_designs/screens/SecondScreen.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  Animation animation;
  AnimationController animationController;
  String time = '';
  String date = '';
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
    setState(() {
      currentImagePath = imageAssets[currentImageIndex];
      
      date = dateTime.day.toString()+'/'+dateTime.month.toString()+'/'+dateTime.year.toString();
    });
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => changeCurrentImage());
    animationController = AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation = Tween(
      begin: 1.0, end: 0.0
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn
    ));
    animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    time = TimeOfDay.now().format(context).toString();
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
          ),
          Positioned(
            top: (MediaQuery.of(context).size.height * 4) / 100,
            child: Container(
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
                        width: MediaQuery.of(context).size.width / 3,
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
                        width: MediaQuery.of(context).size.width / 3,
                        child: Align(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          alignment: Alignment.topCenter,
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(1000)),
                                border: Border.all(color: Colors.red, width: 1, style: BorderStyle.solid),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text('Fajr', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500), textAlign: TextAlign.center,),
                                subtitle: Text('21:00', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500), textAlign: TextAlign.center,),
                              )
                            ),
                          )
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child:   ListTile(
                              title: Text(date, textAlign: TextAlign.end,),
                              subtitle: Text(time, textAlign: TextAlign.end,),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ]
              ),
            ),
          ),
          AnimatedPositioned(
            top: (MediaQuery.of(context).size.height * 30) / 100,
            left: 15,
            right: 15,
            child: AnimatedBuilder(
              animation: animationController,
              builder: (BuildContext context, Widget child) {
                return Transform(
                  transform: Matrix4.translationValues(animation.value * 70, 0.1, 0.6),
                  child: Card(
                    elevation: 2,
                    // borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    child: Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: GridView.count(
                        shrinkWrap: true,
                        primary: false,
                        padding: const EdgeInsets.all(20),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(8),
                            child: Hero(
                              tag: 'adhkar',
                              child: Column(
                                children: <Widget>[
                                  Material(
                                    elevation: 2,
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => SecondScreen()));
                                      },
                                      splashColor: Colors.redAccent,
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          radius: 30,
                                          child: Icon(Icons.perm_media,),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(padding: const EdgeInsets.all(5.0)),
                                  Text('Adhkars', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 30,
                                  child: Icon(Icons.perm_media, size: 30,),
                                ),
                                Padding(padding: const EdgeInsets.all(5.0)),
                                Text('Adhkars', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 30,
                                  child: Icon(Icons.perm_media, size: 30,),
                                ),
                                Padding(padding: const EdgeInsets.all(5.0)),
                                Text('Adhkars', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 30,
                                  child: Icon(Icons.perm_media, size: 30,),
                                ),
                                Padding(padding: const EdgeInsets.all(5.0)),
                                Text('Adhkars', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 30,
                                  child: Icon(Icons.perm_media, size: 30,),
                                ),
                                Padding(padding: const EdgeInsets.all(5.0)),
                                Text('Adhkars', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 30,
                                  child: Icon(Icons.perm_media, size: 30,),
                                ),
                                Padding(padding: const EdgeInsets.all(5.0)),
                                Text('Adhkars', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),),
                              ],
                            ),
                          ),
                        ],
                      )
                    )
                  ),
                );
              }
            ), duration: Duration(seconds: 2),
          )
        ],
      ),
    );
  }
}