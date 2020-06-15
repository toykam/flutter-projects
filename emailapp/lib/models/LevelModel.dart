import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;

part 'LevelModel.g.dart';

@JsonSerializable()
class Level {
  final String name;
  final String id;

  Level(this.name, this.id);


  factory Level.fromJson(Map<String, dynamic> json) => _$LevelFromJson(json);


  static Future<List<Level>> browse () async {
    http.Response response = await http.get('http://toykam.ml/level/all');
    String content = response.body;
    // String content = await rootBundle.loadString('assets/data/levels.json');
    List collection = json.decode(content);
    List<Level> _levels = collection.map((json) => Level.fromJson(json)).toList();
    return _levels;
  }
  
}