import 'dart:async';

import 'package:flutter_news_app/src/api/blogger_api_provider.dart';
import 'package:flutter_news_app/src/model/bloggerArticles/bloggerArticles.dart';

class BloggerApiRepository {
  final _apiProvider = BloggerApiProvider();

  Future<BloggerArticles> fetchBloggerNews({query = ''}) =>
      _apiProvider.fetchBloggerNews(query: query);
}
