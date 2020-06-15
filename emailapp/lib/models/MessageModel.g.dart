// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MessageModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    json['subject'] as String,
    json['body'] as String,
    json['isSelected'] as bool,
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
  'subject': instance.subject,
  'body': instance.body,
  'isSelected': instance.isSelected,
};
