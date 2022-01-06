import 'package:crypto_lab/view/app_bar/app_bar.dart';
import 'package:crypto_lab/view/navigation_bar/nav_bar.dart';
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
