import 'package:crypto_lab/Model/crypto.dart';
import 'package:crypto_lab/View/appBar/app_bar.dart';
import 'package:crypto_lab/View/navigationBar/nav_bar.dart';
import 'package:flutter/material.dart';

import 'package:crypto_lab/View/details/details_screen_body.dart';

class DetailsScreen extends StatelessWidget {
  final Crypto _crypto;
  const DetailsScreen(this._crypto, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const NavBar(),
      appBar: MyAppBar(
        pageTitle: _crypto.name,
      ),
      body: DetailsScreenBody(_crypto),
    );
  }
}