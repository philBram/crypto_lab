import 'package:crypto_lab/view/app_bar/app_bar.dart';
import 'package:crypto_lab/view/navigation_bar/nav_bar.dart';
import 'package:flutter/material.dart';

import 'package:crypto_lab/view/overview/overview_screen_body.dart';

class OverViewScreen extends StatelessWidget {
  const OverViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      endDrawer: NavBar(),
      appBar: MyAppBar(
        pageTitle: "Übersicht",
      ),
      body: OverViewScreenBody(),
    );
  }
}
