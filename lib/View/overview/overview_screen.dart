import 'package:crypto_lab/View/appBar/app_bar.dart';
import 'package:crypto_lab/View/navigationBar/nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'overview_screen_body.dart';

class OverViewScreen extends StatelessWidget {
  const OverViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const NavBar(),
      appBar: const MyAppBar(
        pageTitle: "Übersicht",
      ),
      body: OverViewScreenBody(),
    );
  }
}
