import 'package:flutter/material.dart';

import 'View/custom_colors.dart';
import 'View/home/home_screen.dart';

void main() {
  runApp(const CryptoLab());
}

class CryptoLab extends StatelessWidget {
  const CryptoLab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Lab',
      theme: ThemeData(
        primaryColor: CryptoLabColors.cryptoLabBackground,
        iconTheme: const IconThemeData(color: CryptoLabColors.cryptoLabIcon),
        textTheme: Theme.of(context).textTheme.apply(bodyColor: CryptoLabColors.cryptoLabFont),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}
