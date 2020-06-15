import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;

part 'MessageModel.g.dart';


@JsonSerializable()
class Message {
  final String subject;
  final String body;
  final bool isSelected;

  Message(this.subject, this.body, this.isSelected);

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  static Future<List<Message>> browse () async {
    http.Response response = await http.get('http://www.mocky.io/v2/5e3ff34b3300004200b04cc3');
    String content = response.body;
    List collection = json.decode(content);
    List<Message> _messages = collection.map((json) => Message.fromJson(json)).toList();
    return _messages;
  }
}