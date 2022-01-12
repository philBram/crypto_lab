import 'package:crypto_lab/view/home/news_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreenBody extends StatelessWidget {
  /// crypto_lab background-image
  final String backGroundImage = "assets/images/backGroundImage.gif";

  /// crypto_lab logo
  final String imageLogo = "assets/images/logo_white_simple.png";

  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// BackgroundImage for the hole screen
        SizedBox(
          child: Image.asset(
            backGroundImage,
            fit: BoxFit.cover,
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        _createStackElements(),
      ],
    );
  }

  /// create the crypto_lab logo and the news-list
  Widget _createStackElements() {
    return Column(children: [
      Expanded(
        child: Image.asset(imageLogo, alignment: Alignment.topCenter),
      ),
      const Expanded(
        child: NewsList(),
      ),
    ]);
  }
}
