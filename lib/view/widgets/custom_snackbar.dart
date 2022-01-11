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

  final Duration _duration = const Duration(milliseconds: 2200);
  final String _unknownText = "Unbekannt";

  /// Shows a snackbar with plain text.
  void displayText({required BuildContext context, required SnackbarStatus status, required String displayText}) {
    try {
      ScaffoldMessenger.of(context).showSnackBar(_display(displayText, status));
    } on Exception {
      ScaffoldMessenger.of(context).showSnackBar(_display("", SnackbarStatus.unknown));
    }
  }

  /// Shows a snackbar with a title and text.
  void displayTextWithTitle(
      {required BuildContext context,
      required SnackbarStatus status,
      required String displayText,
      required String displayTitle}) {
    try {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: status == SnackbarStatus.unknown
            ? Text(_unknownText)
            : _createSnackbarContentWithTitle(displayText, displayTitle),
        backgroundColor: _getBackgroundColor(status),
        duration: _duration,
      ));
    } on Exception {
      ScaffoldMessenger.of(context).showSnackBar(_display("", SnackbarStatus.unknown));
    }
  }

  /// Shows a snackbar that prints a processed exception-text.
  void displayException({required BuildContext context, required SnackbarStatus status, required Exception exception}) {
    displayText(context: context, status: status, displayText: exception.toString().replaceAll("Exception: ", ""));
  }

  SnackBar _display(String displayText, SnackbarStatus status) => SnackBar(
        content: status == SnackbarStatus.unknown ? Text(_unknownText) : Text(displayText),
        backgroundColor: _getBackgroundColor(status),
        duration: _duration,
      );

  /// Returns a column, that contains the Text-elements (title and text) and styling.
  Widget _createSnackbarContentWithTitle(String displayText, String displayTitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          displayTitle,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10.0),
        Text(displayText),
      ],
    );
  }

  /// Returns a background color for the shown snackbar by given [status].
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
