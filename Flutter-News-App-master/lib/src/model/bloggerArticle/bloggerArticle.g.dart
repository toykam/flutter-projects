// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bloggerArticle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BloggerArticle _$BloggerArticleFromJson(Map<String, dynamic> json) {
  return BloggerArticle(
    id: json['id'] as String,
    content: json['content'] as String,
    labels: (json['labels'] as List)?.map((e) => e as String)?.toList(),
    title: json['title'] as String,
    url: json['url'] as String,
    published: json['published'] as String,
  );
}

Map<String, dynamic> _$BloggerArticleToJson(BloggerArticle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'labels': instance.labels,
      'title': instance.title,
      'url': instance.url,
      'published': instance.published,
    };
