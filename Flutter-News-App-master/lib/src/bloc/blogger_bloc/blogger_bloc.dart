import 'package:bloc/bloc.dart';
import 'package:flutter_news_app/src/api/blogger_api_repository.dart';
import 'package:flutter_news_app/src/model/bloggerArticles/bloggerArticles.dart';

abstract class BloggerDataState {}

class BloggerDataInitial extends BloggerDataState {}

class BloggerDataLoading extends BloggerDataState {}

class BloggerDataRefresh extends BloggerDataState {}

class BloggerDataSuccess extends BloggerDataState {
  final BloggerArticles data;

  BloggerDataSuccess(this.data);
}

class BloggerDataFailed extends BloggerDataState {
  final String errorMessage;

  BloggerDataFailed(this.errorMessage);
}

class DataEvent {
  final String category;

  DataEvent(this.category);
}

class BloggerBloc extends Bloc<String, BloggerDataState> {
  @override
  BloggerDataState get initialState => BloggerDataInitial();

  String selectedCategory = '';

  @override
  Stream<BloggerDataState> mapEventToState(String category) async* {
    yield BloggerDataLoading();
    final apiRepository = BloggerApiRepository();
    final categoryLowerCase = category;
    print('Selected Category: ' + categoryLowerCase);
    if (categoryLowerCase == 'all') {
      selectedCategory = categoryLowerCase;
      final data = await apiRepository.fetchBloggerNews();
      if (data.error == null) {
        yield BloggerDataSuccess(data);
      } else {
        yield BloggerDataFailed('Failed to fetch data');
      }
    } else if (category == 'refresh') {
      final data = await apiRepository.fetchBloggerNews(
          query: selectedCategory == 'all' ? '' : selectedCategory);
      print('Selected Category: ' + selectedCategory);
      if (data.error == null) {
        yield BloggerDataSuccess(data);
      } else {
        yield BloggerDataFailed('Failed to fetch data');
      }
    } else if (categoryLowerCase != 'all' &&
        categoryLowerCase.length != 0 &&
        categoryLowerCase != '') {
      selectedCategory = categoryLowerCase;
      final data =
          await apiRepository.fetchBloggerNews(query: categoryLowerCase);
      if (data.error == null) {
        yield BloggerDataSuccess(data);
      } else {
        yield BloggerDataFailed(data.error);
      }
    } else {
      yield BloggerDataFailed('Unknown category');
    }
  }
}
