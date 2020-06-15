import 'package:emailapp/models/LevelModel.dart';
import 'package:flutter/material.dart';


class LevelPage extends StatefulWidget {

  LevelPage({Key key}) : super(key: key);

  @override
  _LevelPageState createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {

  Future<List<Level>> levels;
  
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: Level.browse(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                List levels = snapshot.data;
                return ListView.separated(
                  itemBuilder: (context, index) {
                  Level level = levels[index];
                  return ListTile(
                    leading: CircleAvatar(child: Text(level.id)),
                    title: Text(level.name),
                  );
                }, 
                  separatorBuilder: (context, index) => Divider(), 
                  itemCount: levels.length
                );
              }
              break;
          }
        }
      )
    );
  }
}