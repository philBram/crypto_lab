import 'package:flutter/material.dart';

enum SnackbarStatus {
  success,
  failure,
  neutral,
  unknown,
}

class CustomSnackbar {
  /// CustomSnackbar-Singleton
  static final CustomSnackbar _instance = CustomSnackbar._internal();

  factory CustomSnackbar() => _instance;

  CustomSnackbar._internal();

  final Duration _duration = const Duration(seconds: 3);
  final String _unknownText = "Unbekannt";

  void displayText({required BuildContext context, required SnackbarStatus status, required String displayText}) {
    try {
      ScaffoldMessenger.of(context).showSnackBar(_display(displayText, status));
    } on Exception {
      ScaffoldMessenger.of(context).showSnackBar(_display("", SnackbarStatus.unknown));
    }
  }

  void displayTextWithTitle(
      {required BuildContext context,
      required SnackbarStatus status,
      required String displayText,
      required String displayTitle}) {
    try {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: status == SnackbarStatus.unknown ? Text(_unknownText) : Text(displayText),
        backgroundColor: _getBackgroundColor(status),
        duration: _duration,
      ));
    } on Exception {
      ScaffoldMessenger.of(context).showSnackBar(_display("", SnackbarStatus.unknown));
    }
  }

  void displayException({required BuildContext context, required SnackbarStatus status, required Exception exception}) {
    displayText(context: context, status: status, displayText: exception.toString().replaceAll("Exception: ", ""));
  }

  SnackBar _display(String displayText, SnackbarStatus status) => SnackBar(
        content: status == SnackbarStatus.unknown ? Text(_unknownText) : Text(displayText),
        backgroundColor: _getBackgroundColor(status),
        duration: _duration,
      );

  Color _getBackgroundColor(SnackbarStatus status) {
    switch (status) {
      case SnackbarStatus.success:
        return Colors.green;
      case SnackbarStatus.failure:
        return Colors.red;
      case SnackbarStatus.neutral:
        return Colors.white24;
      case SnackbarStatus.unknown:
        return Colors.grey;
      default:
        return Colors.white12;
    }
  }
}
