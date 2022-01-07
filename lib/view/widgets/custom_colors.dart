import 'package:flutter/material.dart';

/// This class holds all custom colors that are used throughout the CryptoLab-application.
class CustomColors {
  /// Font-color for text on dark backgrounds.
  ///
  /// white (0xFFFFFFFF)
  static const int _cryptoLabLightFontPrimaryValue = 0xFFFFFFFF;

  /// Font-color for standard text on bright background.
  ///
  /// brighter black (0xFF363636)
  static const int _cryptoLabStandardFontPrimaryValue = 0xFF363636;

  /// Color for widget-backgrounds.
  ///
  /// dark blue (0xFF0D1036)
  static const int _cryptoLabBackgroundPrimaryValue = 0xFF0D1036;

  /// Color for the app bar-background.
  ///
  /// dark blue (0xFF0D1036)
  static const int _cryptoLabAppBarBackgroundPrimaryValue = 0xFF0D1036;

  /// Color for icons.
  ///
  /// white (0xFFFFFFFF)
  static const int _cryptoLabIconPrimaryValue = 0xFFFFFFFF;

  /// Color for buttons.
  ///
  /// dark blue (0xFF0D1036)
  static const int _cryptoLabButtonPrimaryValue = 0xFF0D1036;

  /// Color for disabled entries.
  ///
  /// darkgray (0xFF333333)
  static const int _cryptoLabDisabledPrimaryValue = 0xFF333333;

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
    cryptoLabDisabled,
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

  static const MaterialColor cryptoLabDisabled = MaterialColor(
    _cryptoLabDisabledPrimaryValue,
    <int, Color>{},
  );
}
