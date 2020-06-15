import 'package:json_annotation/json_annotation.dart';

part 'UserModel.g.dart';


@JsonSerializable()
class User {
  final String email;
  final String name;

  User(this.email, this.name);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  // factory Message.toJson(newMessage) => _$MessageToJson(newMessage);
}