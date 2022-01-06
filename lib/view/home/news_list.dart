import 'dart:async';

import 'package:crypto_lab/model/articles.dart';
import 'package:crypto_lab/view/adaptive_text_size.dart';
import 'package:crypto_lab/controller/crypto_news_api_service.dart';
import 'package:flutter/material.dart';
import 'package:crypto_lab/view/crypto_lab_colors.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsList extends StatefulWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewsList();
}

class _NewsList extends State<NewsList> {
  final BorderRadius _listItemBorderRadius =
      const BorderRadius.all(Radius.circular(10));
  final EdgeInsets _listItemMargin = const EdgeInsets.all(5);
  final EdgeInsets _listItemPadding = const EdgeInsets.fromLTRB(2, 5, 2, 15);
  final double _listItemWidthFactor = 0.9;
  final double _listViewHeightFactor = 0.8;

  final CryptoNewsApiService _cryptoNewsApiService = CryptoNewsApiService();
  late Future<List<Article>> _articleList;

  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  final _scrollDirection = Axis.horizontal;

  late double _listLength;
  final int _yRotationThreshold = 15;
  final double _scrollingSpeed = 0.3;
  double _currentListPosition = 0.0;
  late AutoScrollController _autoScrollController;

  @override
  void initState() {
    super.initState();
    // Make Api call to get Articles and store Future in _articleList for later use
    _articleList = _cryptoNewsApiService.getArticle();

    // get the length for the ListView
    _listLength = double.parse(_cryptoNewsApiService.newsArticleSize);

    _initAutoScrollController();
    _initSensorStreamListener();
  }

  // https://pub.dev/packages/scroll_to_index
  void _initAutoScrollController() {
    _autoScrollController = AutoScrollController(
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: _scrollDirection,
    );
  }

  // Listens to Rotation changes
  // https://pub.dev/packages/sensors_plus
  void _initSensorStreamListener() {
    _streamSubscriptions.add(
      magnetometerEvents.listen(
            (MagnetometerEvent event) {
          setState(() {
            if (event.x > _yRotationThreshold) {
              _currentListPosition = _currentListPosition <= 0.0
                  ? _currentListPosition
                  : _currentListPosition - _scrollingSpeed;
              _scrollToIndex(_currentListPosition.round());
            } else if (event.x < -_yRotationThreshold) {
              _currentListPosition = _currentListPosition > _listLength
                  ? _currentListPosition
                  : _currentListPosition + _scrollingSpeed;
              _scrollToIndex(_currentListPosition.round());
            }
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.bottomCenter,
      // max 50 % of screen (2 columns), _listViewHeightFactor determine height in %
      heightFactor: _listViewHeightFactor,
      child: FutureBuilder(
        future: _articleList,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              controller: _autoScrollController,
              scrollDirection: _scrollDirection,
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) => _createListViewItem(
                  context, snapshot.data[index], index, _autoScrollController),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _createListViewItem(BuildContext context, Article article, int index,
      AutoScrollController autoScrollController) {
    return AutoScrollTag(
      index: index,
      key: ValueKey(index),
      controller: _autoScrollController,
      child: Container(
        margin: _listItemMargin,
        // width of listview item is % value of _listItemWidthFactor
        width: MediaQuery.of(context).size.width * _listItemWidthFactor,
        decoration: BoxDecoration(
          color: CryptoLabColors.cryptoLabBackground.withOpacity(0.8),
          border: Border.all(color: CryptoLabColors.cryptoLabFont),
          borderRadius: _listItemBorderRadius,
        ),
        padding: _listItemPadding,
        child: ListTile(
          // article url is null => pass empty String so no website will be opened
          onTap: () => _launchURL(article.url ?? ""),
          title: _createListViewItemContent(article),
        ),
      ),
    );
  }

  Widget _createListViewItemContent(Article article) {
    // Column with News header, subtitle and lorem ipsum placeholder
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _createArticleText(article.title, 22, FontWeight.bold, 12),
        _createArticleText(article.author, 17, FontWeight.normal, 10),
        _createArticleImage(article.urlToImage, 80),
      ],
    );
  }

  Widget _createArticleText(
      String? articleText, double size, FontWeight weight, flexValue) {
    return Expanded(
      flex: flexValue,
      child: Text(
        // display "Text not found" if article String is null
        articleText ?? "Text not found",
        style: TextStyle(
          // 720 is the medium screen size => responsive Text
          fontSize: AdaptiveTextSize.getAdaptiveTextSize(context, size),
          fontWeight: weight,
        ),
      ),
    );
  }

  Widget _createArticleImage(String? articleImage, flexValue) {
    return Expanded(
      flex: flexValue,
      child: Align(
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image.network(
            articleImage ??
                "https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fwww.trendycovers.com%2Fcovers%2F1324229779.jpg&f=1&nofb=1",
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        ),
      ),
    );
  }

  // https://pub.dev/packages/url_launcher
  // <queries> tag must be added to android/app/src/main/AndroidManifest.xml
  // to be able to open the Browser
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _scrollToIndex(index) {
    _autoScrollController.scrollToIndex(index,
        preferPosition: AutoScrollPosition.begin);
  }
}
