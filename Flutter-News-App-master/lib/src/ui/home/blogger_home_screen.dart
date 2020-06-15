import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/src/bloc/blogger_bloc/blogger_bloc.dart';
import 'package:flutter_news_app/src/managers/ads_manager.dart';
import 'package:flutter_news_app/src/model/bloggerArticle/bloggerArticle.dart';
import 'package:flutter_news_app/src/model/bloggerArticles/bloggerArticles.dart';
import 'package:flutter_news_app/src/model/category/category.dart';
import 'package:flutter_news_app/src/ui/home/common_widget.dart';
import 'package:flutter_news_app/src/ui/home/web_view.dart';
import 'package:url_launcher/url_launcher.dart';

final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

class BloggerHomeScreen extends StatefulWidget {
  @override
  _BloggerHomeScreenState createState() => _BloggerHomeScreenState();
}

class _BloggerHomeScreenState extends State<BloggerHomeScreen> {
  AdsManager _adsManager;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _adsManager = AdsManager();
    _adsManager.showBannerAds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var strToday = getStrToday();
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      key: scaffoldState,
      body: BlocProvider<BloggerBloc>(
        builder: (context) => BloggerBloc(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF1F5F9),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                ),
              ),
              padding: EdgeInsets.only(
                top: mediaQuery.padding.top + 16.0,
                bottom: 16.0,
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      WidgetTitle(strToday),
                    ],
                  ),
//                  SizedBox(height: 8.0),
//                  buildWidgetSearch(),
                  SizedBox(height: 12.0),
                  WidgetCategory(),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildWidgetLabelLatestNews(context),
                    _buildWidgetSubtitleLatestNews(context),
                  ],
                ),
                RefreshButton(),
              ],
            ),
            Expanded(
              child: WidgetLatestNews(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetSubtitleLatestNews(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        'Top stories at the moment',
        style: Theme.of(context).textTheme.caption.merge(
              TextStyle(
                color: Color(0xFF325384).withOpacity(0.5),
              ),
            ),
      ),
    );
  }

  Widget _buildWidgetLabelLatestNews(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        'Latest News',
        style: Theme.of(context).textTheme.subtitle.merge(
              TextStyle(
                fontSize: 18.0,
                color: Color(0xFF325384).withOpacity(0.8),
              ),
            ),
      ),
    );
  }

  Widget buildWidgetSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: EdgeInsets.only(
          left: 12.0,
          top: 8.0,
          right: 12.0,
          bottom: 8.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          color: Colors.white,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'What are you looking for?',
                style: TextStyle(
                  color: Colors.black26,
                ),
              ),
            ),
            Icon(
              Icons.search,
              size: 16.0,
              color: Colors.black26,
            ),
          ],
        ),
      ),
    );
  }
}

class WidgetCategory extends StatefulWidget {
  @override
  _WidgetCategoryState createState() => _WidgetCategoryState();
}

class _WidgetCategoryState extends State<WidgetCategory> {
  AdsManager _adsManager;
  final listCategories = [
    Category('', 'All', 'all'),
    Category('assets/images/img_business.png', 'Politics', 'General Tok'),
    Category('assets/images/img_entertainment.png', 'Entertainment',
        'Entertainment Tok'),
    Category(
        'assets/images/img_health.png', 'Relationship', 'Relationship Tok'),
    Category('assets/images/img_science.png', 'Education', 'Educational Tok'),
    Category('assets/images/img_sport.png', 'Sport', 'Sport Tok'),
    Category('assets/images/img_technology.png', 'Technology', 'Technology'),
  ];
  int indexSelectedCategory = 0;

  @override
  void initState() {
    _adsManager = AdsManager();
    final bloggerBloc = BlocProvider.of<BloggerBloc>(context);
    bloggerBloc.dispatch('all');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloggerBloc = BlocProvider.of<BloggerBloc>(context);
    return Container(
      height: 74,
      child: ListView.builder(
        shrinkWrap: false,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          Category itemCategory = listCategories[index];
          return Padding(
            padding: EdgeInsets.only(
              left: 16.0,
              right: index == listCategories.length - 1 ? 16.0 : 0.0,
            ),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _adsManager.showInterstitialAd();
                    setState(() {
                      indexSelectedCategory = index;
                      bloggerBloc.dispatch(itemCategory.urlParam);
                    });
                  },
                  child: index == 0
                      ? Container(
                          width: 48.0,
                          height: 48.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFBDCDDE),
                            border: indexSelectedCategory == index
                                ? Border.all(
                                    color: Colors.white,
                                    width: 5.0,
                                  )
                                : null,
                          ),
                          child: Icon(
                            Icons.apps,
                            color: Colors.white,
                          ),
                        )
                      : Container(
                          width: 48.0,
                          height: 48.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(itemCategory.image),
                              fit: BoxFit.cover,
                            ),
                            border: indexSelectedCategory == index
                                ? Border.all(
                                    color: Colors.white,
                                    width: 5.0,
                                  )
                                : null,
                          ),
                        ),
                ),
                SizedBox(height: 8.0),
                Text(
                  itemCategory.title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF325384),
                    fontWeight: indexSelectedCategory == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: listCategories.length,
      ),
    );
  }
}

class WidgetLatestNews extends StatefulWidget {
  WidgetLatestNews();

  @override
  _WidgetLatestNewsState createState() => _WidgetLatestNewsState();
}

class _WidgetLatestNewsState extends State<WidgetLatestNews> {
  AdsManager adsManager;

  @override
  void initState() {
    adsManager = AdsManager();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    final bloggerBloc = BlocProvider.of<BloggerBloc>(context);
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        top: 8.0,
        right: 16.0,
        bottom: mediaQuery.padding.bottom + 16.0,
      ),
      child: BlocListener<BloggerBloc, BloggerDataState>(
        listener: (context, state) {
          if (state is BloggerDataFailed) {
            Scaffold.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        child: BlocBuilder(
          bloc: bloggerBloc,
          builder: (BuildContext context, BloggerDataState state) {
            return _buildWidgetContentLatestNews(state, mediaQuery, adsManager);
          },
        ),
      ),
    );
  }

  Widget _buildWidgetContentLatestNews(BloggerDataState state,
      MediaQueryData mediaQuery, AdsManager adsManager) {
    if (state is BloggerDataLoading) {
      return Center(
        child: Platform.isAndroid
            ? CircularProgressIndicator()
            : CupertinoActivityIndicator(),
      );
    } else if (state is BloggerDataSuccess) {
      BloggerArticles data = state.data;
      return ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: data.items.length,
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemBuilder: (context, index) {
          BloggerArticle itemArticle =
              BloggerArticle.fromJson(data.items[index]);
          if (index == 0) {
            return Stack(
              children: <Widget>[
                ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl:
                        'http://3.bp.blogspot.com/-pDENMEG3F_0/XAodC74rw7I/AAAAAAAAAuM/n6dP-GZWotgQpQ-mQDJh0hWymBOH8wpqwCK4BGAYYCw/s1600/header_1_original.png',
                    height: 192.0,
                    width: mediaQuery.size.width,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Platform.isAndroid
                        ? CircularProgressIndicator()
                        : CupertinoActivityIndicator(),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/img_not_found.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (await canLaunch(itemArticle.url)) {
//                      await launch(itemArticle.url);
                      adsManager.showInterstitialAd();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyWebView(url: itemArticle.url)));
                    } else {
                      scaffoldState.currentState.showSnackBar(SnackBar(
                        content: Text('Could not launch news'),
                      ));
                    }
                  },
                  child: Container(
                    width: mediaQuery.size.width,
                    height: 192.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.black.withOpacity(0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [
                          0.0,
                          0.7,
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12.0,
                        top: 12.0,
                        right: 12.0,
                      ),
                      child: Text(
                        itemArticle.title,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12.0,
                        top: 4.0,
                        right: 12.0,
                      ),
                      child: Wrap(
                        children: <Widget>[
                          Icon(
                            Icons.launch,
                            color: Colors.white.withOpacity(0.8),
                            size: 12.0,
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            '${itemArticle.title}',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 11.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return GestureDetector(
              onTap: () async {
                if (await canLaunch(itemArticle.url)) {
//                  await launch(itemArticle.url);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MyWebView(url: itemArticle.url)));
                }
              },
              child: Container(
                width: mediaQuery.size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 100.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              itemArticle.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xFF325384),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.launch,
                                  size: 12.0,
                                  color: Color(0xFF325384).withOpacity(0.5),
                                ),
                                SizedBox(width: 4.0),
                                Text(
                                  itemArticle.title,
                                  style: TextStyle(
                                    color: Color(0xFF325384).withOpacity(0.5),
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ClipRRect(
                        /*child: Image.network(
                          itemArticle.urlToImage ??
                              'http://api.bengkelrobot.net:8001/assets/images/img_not_found.jpg',
                          width: 72.0,
                          height: 72.0,
                          fit: BoxFit.cover,
                        ),*/
                        child: CachedNetworkImage(
                          imageUrl:
                              'http://3.bp.blogspot.com/-pDENMEG3F_0/XAodC74rw7I/AAAAAAAAAuM/n6dP-GZWotgQpQ-mQDJh0hWymBOH8wpqwCK4BGAYYCw/s1600/header_1_original.png',
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              width: 72.0,
                              height: 72.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                          placeholder: (context, url) => Container(
                            width: 72.0,
                            height: 72.0,
                            child: Center(
                              child: Platform.isAndroid
                                  ? CircularProgressIndicator()
                                  : CupertinoActivityIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/img_not_found.jpg',
                            fit: BoxFit.cover,
                            width: 72.0,
                            height: 72.0,
                          ),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      );
    } else {
      return Container();
    }
  }
}

class RefreshButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloggerBloc = BlocProvider.of<BloggerBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: IconButton(
        icon: Icon(Icons.refresh),
        onPressed: () => _bloggerBloc.dispatch('refresh'),
      ),
    );
  }
}
