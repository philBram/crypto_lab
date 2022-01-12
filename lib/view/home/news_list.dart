import 'dart:async';

import 'package:crypto_lab/model/articles.dart';
import 'package:crypto_lab/view/adaptive_text_size.dart';
import 'package:crypto_lab/controller/crypto_news_api_service.dart';
import 'package:flutter/material.dart';
import 'package:crypto_lab/view/widgets/custom_colors.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsList extends StatefulWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewsList();
}

class _NewsList extends State<NewsList> {
  /// values for controlling the appearance of the list-view
  final BorderRadius _listItemBorderRadius = const BorderRadius.all(Radius.circular(10));
  final EdgeInsets _listItemMargin = const EdgeInsets.all(5);
  final EdgeInsets _listItemPadding = const EdgeInsets.fromLTRB(2, 5, 2, 15);
  final double _listItemWidthFactor = 0.9;
  final double _listViewHeightFactor = 0.8;

  /// API service and list for the returned future from the API service
  final CryptoNewsApiService _cryptoNewsApiService = CryptoNewsApiService();
  late Future<List<Article>> _articleList;

  /// StreamSubscription for the magnetometer (sensor_plus)
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  /// scroll_to_index needs a AutoScrollController
  final _scrollDirection = Axis.horizontal;
  late AutoScrollController _autoScrollController;

  /// values to determine the scroll-behaviour of the list-view based on the values from the magnetometer
  late double _listLength;
  final int _yRotationThreshold = 15;
  final double _scrollingSpeed = 0.3;
  double _currentListPosition = 0.0;

  @override
  void initState() {
    super.initState();
    /// Make Api call to get Articles and store Future in _articleList for later use
    _articleList = _cryptoNewsApiService.getArticle();

    /// get the length for the ListView from the length of elements in the API call
    _listLength = double.parse(_cryptoNewsApiService.newsArticleSize);

    _initAutoScrollController();
    _initSensorStreamListener();
  }

  /// https://pub.dev/packages/scroll_to_index
  void _initAutoScrollController() {
    _autoScrollController = AutoScrollController(
      viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: _scrollDirection,
    );
  }

  /// https://pub.dev/packages/sensors_plus
  void _initSensorStreamListener() {
    _streamSubscriptions.add(
      magnetometerEvents.listen(
        (MagnetometerEvent event) {
          if (mounted) {
            setState(() {
              /// scroll to the left
              if (event.x > _yRotationThreshold) {
                _currentListPosition =
                    _currentListPosition <= 0.0 ? _currentListPosition : _currentListPosition - _scrollingSpeed;
                _scrollToIndex(_currentListPosition.round());
                /// scroll to the right
              } else if (event.x < -_yRotationThreshold) {
                _currentListPosition =
                    _currentListPosition > _listLength ? _currentListPosition : _currentListPosition + _scrollingSpeed;
                _scrollToIndex(_currentListPosition.round());
              }
            });
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.bottomCenter,
      /// max 50 % of screen (2 columns), _listViewHeightFactor determine height in %
      heightFactor: _listViewHeightFactor,
      child: FutureBuilder(
        future: _articleList,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              /// needed for the ability to scroll to a specific index
              controller: _autoScrollController,
              scrollDirection: _scrollDirection,
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) =>
                  _createListViewItem(context, snapshot.data[index], index, _autoScrollController),
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

  Widget _createListViewItem(
      BuildContext context, Article article, int index, AutoScrollController autoScrollController) {
    /// needed for the ability to scroll to a specific index
    return AutoScrollTag(
      index: index,
      key: ValueKey(index),
      controller: _autoScrollController,
      child: Container(
        margin: _listItemMargin,
        /// width of listview item is % value of _listItemWidthFactor
        width: MediaQuery.of(context).size.width * _listItemWidthFactor,
        decoration: BoxDecoration(
          color: CustomColors.cryptoLabBackground.withOpacity(0.8),
          border: Border.all(
            color: CustomColors.cryptoLabLightFont,
          ),
          borderRadius: _listItemBorderRadius,
        ),
        padding: _listItemPadding,
        child: ListTile(
          /// article url is null => pass empty String so no website will be opened
          onTap: () => _launchURL(article.url ?? ""),
          title: _createListViewItemContent(article),
        ),
      ),
    );
  }

  Widget _createListViewItemContent(Article article) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _createArticleText(article.title, 22, FontWeight.bold, 12),
        _createArticleText(article.author, 17, FontWeight.normal, 10),
        _createArticleImage(article.urlToImage, 80),
      ],
    );
  }

  Widget _createArticleText(String? articleText, double size, FontWeight weight, flexValue) {
    return Expanded(
      flex: flexValue,
      child: Text(
        /// display "Text nicht gefunden" if article String is null
        articleText ?? "Text nicht gefunden",
        style: TextStyle(
          /// 720 is the medium screen size => responsive Text
          color: CustomColors.cryptoLabLightFont,
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

  /// https://pub.dev/packages/url_launcher
  ///
  /// <queries> tag must be added to android/app/src/main/AndroidManifest.xml to be able to open the Browser
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  /// scroll to [index] position of the list-view
  void _scrollToIndex(index) {
    _autoScrollController.scrollToIndex(index, preferPosition: AutoScrollPosition.begin);
  }

  /// cancel all stream-subscriptions
  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }
}
