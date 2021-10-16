import 'package:flutter/material.dart';

class CryptoLabColors {
  static const int _cryptoLabFontPrimaryValue = 0xFF363636;
  static const int _cryptoLabBackgroundPrimaryValue = 0xFF9093ab;
  static const int _cryptoLabIconPrimaryValue = 0xFF9093ab;

  static const MaterialColor cryptoLabFont = MaterialColor(
    _cryptoLabFontPrimaryValue,
    <int, Color>{

    },
  );

  static const MaterialColor cryptoLabBackground = MaterialColor(
    _cryptoLabBackgroundPrimaryValue,
    <int, Color>{

    },
  );

  static const MaterialColor cryptoLabIcon = MaterialColor(
    _cryptoLabBackgroundPrimaryValue,
    <int, Color>{

    },
  );

  static const List<MaterialColor> primaries = <MaterialColor>[
    cryptoLabFont,
    cryptoLabBackground,
    cryptoLabIcon,
  ];
}
