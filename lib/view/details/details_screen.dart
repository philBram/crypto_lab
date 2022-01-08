import 'package:crypto_lab/model/crypto.dart';
import 'package:crypto_lab/view/app_bar/app_bar.dart';
import 'package:crypto_lab/view/navigation_bar/nav_bar.dart';
import 'package:flutter/material.dart';

import 'package:crypto_lab/view/details/details_screen_body.dart';

class DetailsScreen extends StatelessWidget {
  final Crypto _crypto;

  const DetailsScreen(this._crypto, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const NavBar(),
      appBar: MyAppBar(
        // display "name not found" if crypto name is null
        pageTitle: _crypto.name ?? "name not found",
      ),
      body: DetailsScreenBody(_crypto),
    );
  }
}
