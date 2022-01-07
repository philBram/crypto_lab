import 'package:crypto_lab/view/widgets/custom_colors.dart';
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

class CustomPopup extends StatefulWidget {
  final BuildContext buildContext;
  final PopupType popupType;
  final String title;
  final String content;

  /// Determines if the user is confirming the popup, only then sets this to true, otherwise false.
  final Function(bool) onConfirmationCallback;

  final Function(List<String>)? onConfirmationTextFieldValues;

  const CustomPopup({
    required this.buildContext,
    required this.popupType,
    required this.title,
    required this.content,
    required this.onConfirmationCallback,
    this.onConfirmationTextFieldValues,
    Key? key,
  }) : super(key: key);

  @override
  CustomPopupState createState() {
    return CustomPopupState();
  }
}

class CustomPopupState extends State<CustomPopup> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => _buildAlertDialog();

  Widget _buildAlertDialog() {
    return AlertDialog(
      scrollable: true,
      title: Text(widget.title),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.content),
            for (Widget widget in _buildInputFields()) widget,
          ],
        ),
      ),
      actions: [
        _isConfirmationPopup() ? _buildCancelButton() : const SizedBox.shrink(),
        _isConfirmationPopup() ? _buildConfirmationButton() : _buildRogerButton(),
      ],
    );
  }

  /// Checks if the [popupType] is a standard confirmation-type or an inputField-type.
  bool _isConfirmationPopup() {
    if (widget.popupType == PopupType.confirmation || _isInputFieldPopup()) {
      return true;
    }
    return false;
  }

  /// Checks if the [popupType] is one of the inputField-types.
  bool _isInputFieldPopup() {
    switch (widget.popupType) {
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
    List<Widget> inputFieldWidgets = [];
    inputFieldWidgets.add(
      const SizedBox(height: 10.0),
    );
    if (widget.popupType == PopupType.changePassword) {
      TextFormField passwordFormField = TextFormField(validator: (value) {
        if (value == null || value.isEmpty) {
          return "Bitte etwas eingeben!";
        } else if (value.length < 6) {
          return "Passwort-Mindestlänge von 6 Zeichen!";
        }
        return null;
      });
      inputFieldWidgets.add(passwordFormField);
      return inputFieldWidgets;
    } else if (widget.popupType == PopupType.oneStandardInputField ||
        widget.popupType == PopupType.twoStandardInputFields) {
      if (widget.popupType == PopupType.twoStandardInputFields) {}
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
      ),
      onPressed: () {
        Navigator.pop(widget.buildContext);
        widget.onConfirmationCallback(true);
      },
    );
  }

  /// Builds an "Abbrechen"-Button.
  Widget _buildCancelButton() {
    return TextButton(
      child: const Text(
        cancelButtonText,
      ),
      onPressed: () {
        Navigator.pop(widget.buildContext);
        widget.onConfirmationCallback(false);
      },
    );
  }

  /// Builds a "Bestätigen"-Button.
  Widget _buildConfirmationButton() {
    return TextButton(
      child: const Text(
        confirmationButtonText,
      ),
      onPressed: () {
        if (_isInputFieldPopup()) {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
          }
        }
        widget.onConfirmationCallback(true);
      },
    );
  }
}
