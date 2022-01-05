import 'package:crypto_lab/View/crypto_lab_colors.dart';
import 'package:flutter/material.dart';

import '../globals.dart';

enum PopupType {
  confirmation,
  success,
  failed,
}

class Popup extends StatelessWidget {
  final BuildContext buildContext;
  final PopupType popupType;
  final String title;
  final String content;
  /// Determines if the user is confirming the popup, only then sets this to true, otherwise false.
  final Function(bool) onConfirmationCallback;

  const Popup({
    required this.buildContext,
    required this.popupType,
    required this.title,
    required this.content,
    required this.onConfirmationCallback,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => _buildAlertDialog();

  Widget _buildAlertDialog() {
    return AlertDialog(
      title: Text(title, style: const TextStyle(color: CryptoLabColors.cryptoLabFont)),
      content: Text(content, style: const TextStyle(color: CryptoLabColors.cryptoLabFont)),
      actions: [
        _isConfirmationPopup() ? _buildCancelButton() : const SizedBox.shrink(),
        _isConfirmationPopup() ? _buildConfirmationButton() : _buildRogerButton(),
      ],
    );
  }

  bool _isConfirmationPopup() {
    if (popupType == PopupType.confirmation) {
      return true;
    }
    return false;
  }

  /// Builds a "Verstanden"-Button.
  Widget _buildRogerButton() {
    return TextButton(
      child: const Text(
        confirmationButtonText,
        style: TextStyle(color: CryptoLabColors.cryptoLabBackground),
      ),
      onPressed: () {
        Navigator.pop(buildContext);
        onConfirmationCallback(true);
      },
    );
  }

  /// Builds an "Abbrechen"-Button.
  Widget _buildCancelButton() {
    return TextButton(
      child: const Text(
        cancelButtonText,
        style: TextStyle(color: CryptoLabColors.cryptoLabBackground),
      ),
      onPressed: () {
        Navigator.pop(buildContext);
        onConfirmationCallback(false);
      },
    );
  }

  /// Builds a "Bestätigen"-Button.
  Widget _buildConfirmationButton() {
    return TextButton(
      child: const Text(
        confirmationButtonText,
        style: TextStyle(color: CryptoLabColors.cryptoLabBackground),
      ),
      onPressed: () => onConfirmationCallback(true),
    );
  }
}
