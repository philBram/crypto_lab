import 'package:crypto_lab/View/settings/settings_screen_body.dart';
import 'package:crypto_lab/view/app_bar/app_bar.dart';
import 'package:crypto_lab/view/navigation_bar/nav_bar.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      endDrawer: NavBar(),
      appBar: MyAppBar(
        pageTitle: "Einstellungen",
      ),
      body: SettingsScreenBody(),
    );
  }
}
