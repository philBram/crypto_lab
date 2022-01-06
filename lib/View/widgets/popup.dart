import 'package:crypto_lab/View/crypto_lab_colors.dart';
import 'package:flutter/material.dart';

import '../globals.dart';

enum PopupType {
  confirmation,
  success,
  failed,
  changePassword,
  oneStandardInputField,
  twoStandardInputFields,
}

class Popup extends StatelessWidget {
  final BuildContext buildContext;
  final PopupType popupType;
  final String title;
  final String content;

  /// Determines if the user is confirming the popup, only then sets this to true, otherwise false.
  final Function(bool) onConfirmationCallback;

  final Function(List<String>)? onConfirmationTextFieldValues;

  const Popup({
    required this.buildContext,
    required this.popupType,
    required this.title,
    required this.content,
    required this.onConfirmationCallback,
    this.onConfirmationTextFieldValues,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => _buildAlertDialog();

  Widget _buildAlertDialog() {
    return AlertDialog(
      title: Text(title, style: const TextStyle(color: CryptoLabColors.cryptoLabFont)),
      content: Column(
        children: [
          Text(content, style: const TextStyle(color: CryptoLabColors.cryptoLabFont)),
          // _isInputFieldPopup() ? _buildInputFields() : const SizedBox.shrink(),
          for (Widget widget in _buildInputFields()) widget,
        ],
      ),
      actions: [
        _isConfirmationPopup() ? _buildCancelButton() : const SizedBox.shrink(),
        _isConfirmationPopup() ? _buildConfirmationButton() : _buildRogerButton(),
      ],
    );
  }

  bool _isConfirmationPopup() {
    if (popupType == PopupType.confirmation || _isInputFieldPopup()) {
      return true;
    }
    return false;
  }

  bool _isInputFieldPopup() {
    switch (popupType) {
      case PopupType.oneStandardInputField:
        return true;
      case PopupType.twoStandardInputFields:
        return true;
      case PopupType.changePassword:
        return true;
      default:
        return false;
    }
  }

  /// Builds input-field(s) if [PopupType] is [passwordInputField], [oneStandardInputField] or [twoStandardInputFields].
  List<Widget> _buildInputFields() {
    if (_isInputFieldPopup()) {
      List<Widget> inputFieldWidgets = [];

      if (popupType == PopupType.changePassword) {
      } else if (popupType == PopupType.oneStandardInputField || popupType == PopupType.twoStandardInputFields) {
        if (popupType == PopupType.twoStandardInputFields) {}
      }
      return inputFieldWidgets;
    } else {
      return const <Widget>[];
    }
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
