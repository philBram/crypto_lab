import 'package:flutter/material.dart';

class AdaptiveTextSize {

  static double getAdaptiveTextSize(BuildContext context, dynamic value) {
    // 720 is the medium screen height => returns responsive TextSize
    return (value / 720) * MediaQuery.of(context).size.height;
  }
}