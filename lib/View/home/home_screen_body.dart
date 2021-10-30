import 'package:crypto_lab/View/home/news_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreenBody extends StatelessWidget {
  // https://www.hicetnunc.xyz/objkt/278284
  final String backGroundImage = "https://ipfs.io/ipfs/bafybeicass6d3ftqyfigxciwfysnzm4aobfjuk4zvtueenvqqpjo3p75ju";
  final String backGroundImagePlaceholder = "assets/images/backGroundImagePlaceholder.jpg";
  // [logo_white.png, logo_white_simple.png] in assets/images
  final String imageLogo = "assets/images/logo_white_simple.png";

  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // BackgroundImage for the hole screen
        SizedBox(
          child: FadeInImage.assetNetwork(
            // show placeholder as long as network image is not loaded yet
            placeholder: backGroundImagePlaceholder,
            image: backGroundImage,
            fadeInDuration: const Duration(milliseconds: 1),
            fit: BoxFit.cover,
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        _createStackElements(),
      ],
    );
  }

  Widget _createStackElements() {
    // 2 Columns with a logo and a ListView to display crypto news
    return Column(
        children: [
          // logo
          Expanded(child:
            Image.asset(imageLogo, alignment: Alignment.topCenter),
          ),
          const Expanded(child:
            NewsList(),
          ),
        ]
    );
  }
}
