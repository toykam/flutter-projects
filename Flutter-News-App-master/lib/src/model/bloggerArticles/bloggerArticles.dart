import 'package:json_annotation/json_annotation.dart';

part 'bloggerArticles.g.dart';

@JsonSerializable()
class BloggerArticles {
  List items;
  @JsonKey(ignore: true)
  String error;

  BloggerArticles({this.items});

  factory BloggerArticles.fromJson(Map<String, dynamic> json) =>
      _$BloggerArticlesFromJson(json);
  Map<String, dynamic> toJson() => _$BloggerArticlesToJson(this);
  BloggerArticles.withError(this.error);

  @override
  String toString() {
    // TODO: implement toString
    return 'items: $items';
  }
}
