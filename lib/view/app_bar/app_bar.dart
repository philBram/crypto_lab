import 'package:flutter/material.dart';

import '../widgets/custom_colors.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final String pageTitle;

  const MyAppBar({Key? key, required this.pageTitle}) : super(key: key);

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: CustomColors.cryptoLabLightFont),
      backgroundColor: CustomColors.cryptoLabAppBarBackground,
      elevation: 0,
      title: Text(
        pageTitle,
        style: const TextStyle(color: CustomColors.cryptoLabLightFont),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
