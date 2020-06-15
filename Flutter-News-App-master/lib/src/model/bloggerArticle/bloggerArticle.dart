import 'package:json_annotation/json_annotation.dart';

part 'bloggerArticle.g.dart';

@JsonSerializable()
class BloggerArticle {
  String id;
  String content;
  List<String> labels;
  String title;
  String url;
  String published;

  BloggerArticle(
      {this.id,
      this.content,
      this.labels,
      this.title,
      this.url,
      this.published});

  factory BloggerArticle.fromJson(Map<String, dynamic> json) =>
      _$BloggerArticleFromJson(json);

  Map<String, dynamic> toJson() => _$BloggerArticleToJson(this);

  @override
  String toString() {
    return 'Category{id: $id, title: $title, labels: $labels, url: $url, published: $published}';
  }
}
