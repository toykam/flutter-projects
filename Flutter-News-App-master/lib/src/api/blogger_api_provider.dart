import 'package:dio/dio.dart';
import 'package:flutter_news_app/src/model/bloggerArticles/bloggerArticles.dart';

class BloggerApiProvider {
  final Dio _dio = Dio();
//  final String _baseUrl =
//      'https://newsapi.org/v2/top-headlines?country=id&apiKey=9d3512ec9512452da1ad6bf7dc157c68';
  final String _bloggerBaseurl =
      'https://www.googleapis.com/blogger/v3/blogs/2229924374083524364/posts?key=AIzaSyCyoh2_EUO7qDVj1KwYxkUCxTrvHw-B-k8';
  void printOutError(error, StackTrace stacktrace) {
    print('Exception occured: $error with stacktrace: $stacktrace');
  }

  Future<BloggerArticles> fetchBloggerNews({query = ''}) async {
    try {
      print(query.toString().replaceAll(' ', '+'));
      final response = (query == '')
          ? await _dio.get(_bloggerBaseurl)
          : await _dio.get(_bloggerBaseurl +
              '&labels=' +
              query.toString().replaceAll(' ', '+'));
      print('API Respons: ' + response.toString());
      return BloggerArticles.fromJson(response.data);
    } catch (error, stacktrace) {
      printOutError(error, stacktrace);
      return BloggerArticles.withError('$error');
    }
  }

//  Future<ResponseTopHeadlinesNews> getBloggerPl() async {
//    try {
//      final response = await _dio.get('$_baseUrl&category=technology');
//      return ResponseTopHeadlinesNews.fromJson(response.data);
//    } catch (error, stacktrace) {
//      printOutError(error, stacktrace);
//      return ResponseTopHeadlinesNews.withError('$error');
//    }
//  }

}
