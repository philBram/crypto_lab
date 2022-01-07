import 'package:flutter/material.dart';

/// This class holds all custom colors that are used throughout the CryptoLab-application.
class CustomColors {
  /// Font-color for the app bar.
  ///
  /// white (0xFFFFFFFF)
  static const int _cryptoLabLightFontPrimaryValue = 0xFFFFFFFF;

  /// Font-color for standard text.
  ///
  /// brighter black (0xFF363636)
  static const int _cryptoLabStandardFontPrimaryValue = 0xFF363636;

  /// Color for widget-backgrounds.
  ///
  /// purple-ish (0xFF8452b3)
  static const int _cryptoLabBackgroundPrimaryValue = 0xFF0D1036;

  /// Color for the app bar-background.
  ///
  /// deepPurple (0xFF673AB7)
  static const int _cryptoLabAppBarBackgroundPrimaryValue = 0xFF0D1036;

  /// Color for icons.
  ///
  /// brighter black (0xFF363636)
  static const int _cryptoLabIconPrimaryValue = 0xFFFFFFFF;

  /// Color for buttons.
  ///
  /// deepPurple (0xFF673AB7)
  static const int _cryptoLabButtonPrimaryValue = 0xFF673ab7;

  static int get cryptoLabBackgroundPrimaryValue {
    return _cryptoLabBackgroundPrimaryValue;
  }

  static const List<MaterialColor> primaries = <MaterialColor>[
    cryptoLabLightFont,
    cryptoLabStandardFont,
    cryptoLabBackground,
    cryptoLabAppBarBackground,
    cryptoLabIcon,
    cryptoLabButton,
  ];

  static const MaterialColor cryptoLabLightFont = MaterialColor(
    _cryptoLabLightFontPrimaryValue,
    <int, Color>{},
  );

  static const MaterialColor cryptoLabStandardFont = MaterialColor(
    _cryptoLabStandardFontPrimaryValue,
    <int, Color>{},
  );

  static const MaterialColor cryptoLabBackground = MaterialColor(
    _cryptoLabBackgroundPrimaryValue,
    <int, Color>{},
  );

  static const MaterialColor cryptoLabAppBarBackground = MaterialColor(
    _cryptoLabAppBarBackgroundPrimaryValue,
    <int, Color>{},
  );

  static const MaterialColor cryptoLabIcon = MaterialColor(
    _cryptoLabIconPrimaryValue,
    <int, Color>{},
  );

  static const MaterialColor cryptoLabButton = MaterialColor(
    _cryptoLabButtonPrimaryValue,
    <int, Color>{},
  );
}
