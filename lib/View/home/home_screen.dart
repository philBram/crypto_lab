import 'package:crypto_lab/View/appBar/app_bar.dart';
import 'package:crypto_lab/View/navigationBar/nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_screen_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      endDrawer: NavBar(),
      appBar: MyAppBar(
        pageTitle: "Home",
      ),
      body: HomeScreenBody(),
    );
  }
}
