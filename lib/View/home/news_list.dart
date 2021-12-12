import 'package:flutter/material.dart';
import 'package:crypto_lab/View/crypto_lab_colors.dart';

class NewsList extends StatelessWidget {
  final BorderRadius _listItemBorderRadius = const BorderRadius.all(Radius.circular(10));
  final EdgeInsets _listItemMargin = const EdgeInsets.all(5);
  final EdgeInsets _listItemPadding = const EdgeInsets.all(10);
  final double _listItemWidthFactor = 0.9;
  final double _listViewHeightFactor = 0.7;

  const NewsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        alignment: Alignment.bottomCenter,
        // max 50 % of screen (2 columns), _listViewHeightFactor determine height in %
        heightFactor: _listViewHeightFactor,
        child: ListView.builder(
          itemCount: 20,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => _createListViewItem(index, context),
        )
    );
  }

  Widget _createListViewItem(int index, BuildContext context) {
    return Container(
        margin: _listItemMargin,
        // width of listview item is % value of _listItemWidthFactor
        width: MediaQuery.of(context).size.width * _listItemWidthFactor,
        decoration: BoxDecoration(
          color: CryptoLabColors.cryptoLabBackground.withOpacity(0.8),
          border: Border.all(color: CryptoLabColors.cryptoLabFont),
          borderRadius: _listItemBorderRadius,
        ),
        child: Padding(
            padding: _listItemPadding,
            child: ListTile(
              // TODO: implement onTap for news API
              onTap: () {},
              title: _createListViewItemContent(index),
            )
        )
    );
  }

  // TODO: replace content of the ListView with data from API to display crypto news
  Widget _createListViewItemContent(int index) {
    // Column with News header, subtitle and lorem ipsum placeholder
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 2,
              child: Text(
                "News Header $index",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: CryptoLabColors.cryptoLabFont,
                ),
              )
          ),
          Expanded(
              flex: 2,
              child: Text(
                  "News Subtitle $index",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: CryptoLabColors.cryptoLabFont,
                  )
              )
          ),
          const Expanded(
              flex: 8,
              child: Text("Lorem ipsum dolor sit amet,\n"
                  "consectetur adipiscing elit,\n"
                  "sed do eiusmod tempor incididunt\n"
                  "ut labore et dolore magna aliqua.\n"
                  "ut labore et dolore magna aliqua.\n"
                  "ut labore et dolore magna aliqua.\n"
                  "ut labore et dolore magna aliqua.\n"
                  "ut labore et dolore magna aliqua.\n"
                  "ut labore et dolore magna aliqua.\n"
                  "ut labore et dolore magna aliqua.\n",
                  style: TextStyle(
                    color: CryptoLabColors.cryptoLabFont,
                  )
              )
          )
        ]
    );
  }
}
