import 'package:crypto_lab/View/appBar/app_bar.dart';
import 'package:crypto_lab/View/navigationBar/nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'favorites_screen_body.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      endDrawer: NavBar(),
      appBar: MyAppBar(
        pageTitle: "Favoriten",
      ),
      body: FavoritesScreenBody(),
    );
  }
}
