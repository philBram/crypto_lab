import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreenBody extends StatelessWidget {
  // https://www.hicetnunc.xyz/objkt/278284
  final AssetImage backGroundImage = const AssetImage("assets/images/animated_background_image.gif");
  /* final NetworkImage backGroundImage = const NetworkImage(
      "https://now.northropgrumman.com/wp-content/uploads/sites/2/2018/03/thinkstockphotos-816838496_72dpi.jpg"
  ); */
  // [logo_white.png, logo_white_simple.png] in assets/images
  final AssetImage imageLogo = const AssetImage("assets/images/logo_white_simple.png");

  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // BackgroundImage for the hole screen
        SizedBox(
          child: Image(image: backGroundImage, fit: BoxFit.cover),
          height: MediaQuery.of(context).size.height,
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
            Image(image: imageLogo,alignment: Alignment.topCenter),
          ),
        ]
    );
  }
}
