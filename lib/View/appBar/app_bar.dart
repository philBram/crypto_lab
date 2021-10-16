import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../custom_colors.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final String pageTitle;

  const MyAppBar({Key? key, required this.pageTitle}) : super(key: key);

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: CryptoLabColors.cryptoLabFont),
      backgroundColor: CryptoLabColors.cryptoLabBackground,
      elevation: 0,
      title: Text(
        pageTitle,
        style: const TextStyle(color: CryptoLabColors.cryptoLabFont),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}