import 'package:crypto_lab/View/appBar/app_bar.dart';
import 'package:crypto_lab/View/navigationBar/nav_bar.dart';
import 'package:crypto_lab/View/settings/settings_screen_body.dart';
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
