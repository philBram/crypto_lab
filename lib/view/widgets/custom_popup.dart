import 'package:crypto_lab/controller/authentication_service.dart';
import 'package:crypto_lab/controller/validator.dart';
import 'package:flutter/material.dart';

import '../globals.dart';
import 'custom_colors.dart';

enum PopupType {
  confirmation,
  success,
  failed,
  changePassword,
  oneStandardInputField,
  twoStandardInputFields,
  oneDigitInputField,
}

enum PasswordInputFieldType {
  oldPassword,
  newPassword,
  newPasswordConfirmation,
}

/// A custom popup can be build by only providing a [popupType], a [title] and the text[content].
///
/// A [onConfirmationCallback] and [onConfirmationTextFieldValues] are optional. These callbacks are meant to receive a pressed
/// button-click within the popup or to get the values of the text-fields if provided.
class CustomPopup extends StatefulWidget {
  final BuildContext buildContext;
  final PopupType popupType;
  final String title;
  final String content;

  /// Determines if the user is confirming the popup, only then sets this to true, otherwise false.
  final Function(bool)? onConfirmationCallback;

  final Function(List<String>)? onConfirmationTextFieldValues;

  const CustomPopup({
    required this.buildContext,
    required this.popupType,
    required this.title,
    required this.content,
    this.onConfirmationCallback,
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

  final _textEditingController1 = TextEditingController();
  final _textEditingController2 = TextEditingController();
  final _textEditingController3 = TextEditingController();

  bool checkCurrentPasswordValid = true;

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
      case PopupType.oneDigitInputField:
        return true;
      default:
        return false;
    }
  }

  /// Builds input-field(s) if [PopupType] is [passwordInputField], [oneStandardInputField] or [twoStandardInputFields].
  ///
  /// Can be extended if needed.
  List<Widget> _buildInputFields() {
    List<Widget> inputFieldWidgets = [];
    inputFieldWidgets.add(
      const SizedBox(height: 10.0),
    );
    if (widget.popupType == PopupType.changePassword) {
      List<TextFormField> passwordFormFields = [
        _buildPasswordInputField(PasswordInputFieldType.oldPassword),
        _buildPasswordInputField(PasswordInputFieldType.newPassword),
        _buildPasswordInputField(PasswordInputFieldType.newPasswordConfirmation)
      ];
      inputFieldWidgets.addAll(passwordFormFields);
      return inputFieldWidgets;
    } else if (widget.popupType == PopupType.oneStandardInputField ||
        widget.popupType == PopupType.twoStandardInputFields) {
      // TODO: add popup with one standard input field when needed
      if (widget.popupType == PopupType.twoStandardInputFields) {
        // TODO: add popup with two standard input fields when needed
      }
      return inputFieldWidgets;
    }
    else if (widget.popupType == PopupType.oneDigitInputField) {
      List<TextFormField> digitInputFields = [
        _buildDigitInputField(),
      ];
      inputFieldWidgets.addAll(digitInputFields);
      return inputFieldWidgets;
    }
    else {
    return const <Widget>[];
    }
  }

  /// Builds a "Verstanden"-Button.
  Widget _buildRogerButton() {
    return TextButton(
      style: TextButton.styleFrom(
        primary: CustomColors.cryptoLabLightFont,
        backgroundColor: CustomColors.cryptoLabButton,
      ),
      child: const Text(
        rogerButtonText,
      ),
      onPressed: () {
        Navigator.pop(widget.buildContext);
      },
    );
  }

  /// Builds an "Abbrechen"-Button.
  Widget _buildCancelButton() {
    return TextButton(
      style: TextButton.styleFrom(
        primary: CustomColors.cryptoLabLightFont,
        backgroundColor: Colors.red.shade900,
      ),
      child: const Text(
        cancelButtonText,
      ),
      onPressed: () {
        Navigator.pop(widget.buildContext);
      },
    );
  }

  /// Builds a "Bestätigen"-Button.
  Widget _buildConfirmationButton() {
    return TextButton(
      key: const Key("popupConfirmationButton"),
      style: TextButton.styleFrom(
        primary: CustomColors.cryptoLabLightFont,
        backgroundColor: CustomColors.cryptoLabButton,
      ),
      child: const Text(
        confirmationButtonText,
      ),
      onPressed: () async {
        if (_isInputFieldPopup()) {
          if (widget.popupType == PopupType.changePassword) {
            checkCurrentPasswordValid =
            await AuthenticationService().validateCurrentPassword(_textEditingController1.text);
            setState(() {});
            if (_formKey.currentState!.validate() && checkCurrentPasswordValid) {
              _formKey.currentState!.save();
              widget.onConfirmationTextFieldValues!([
                _textEditingController2.text,
              ]);
            }
          }
          else if (widget.popupType == PopupType.oneDigitInputField) {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              widget.onConfirmationTextFieldValues!([
                _textEditingController1.text,
              ]);
            }
          }
          else if (widget.popupType == PopupType.oneStandardInputField) {
            // TODO: implement if necessary
          }
        }
        widget.onConfirmationCallback!(true);
      },
    );
  }

  /// Builds an appropriate password input field depending on [passwordInputFieldType]
  TextFormField _buildPasswordInputField(PasswordInputFieldType passwordInputFieldType) {
    return TextFormField(
      key: Key(passwordInputFieldType.toString() + "InputField"),
      decoration: _getPasswordInputDecoration(passwordInputFieldType),
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      controller: _getPasswordTextEditingController(passwordInputFieldType),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validatorNoInput;
        } else if (passwordInputFieldType != PasswordInputFieldType.oldPassword) {
          return Validator().validatePassword(value);
        } else if ((passwordInputFieldType == PasswordInputFieldType.newPasswordConfirmation) &&
            (_textEditingController2.text != value)) {
          return validatorPasswordsDontMatch;
        }
        return null;
      },
    );
  }

  TextFormField _buildDigitInputField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: "Eingabe",
      ),
      controller: _textEditingController1,
      validator: (value) => Validator().validatePositiveNumber(value),
    );
  }

  /// Returns the input TextEditingController for the password input fields by given [passwordInputFieldType].
  TextEditingController _getPasswordTextEditingController(PasswordInputFieldType passwordInputFieldType) {
    switch (passwordInputFieldType) {
      case PasswordInputFieldType.oldPassword:
        return _textEditingController1;
      case PasswordInputFieldType.newPassword:
        return _textEditingController2;
      case PasswordInputFieldType.newPasswordConfirmation:
        return _textEditingController3;
    }
  }

  /// Returns the input decorations for the password input fields by given [passwordInputFieldType].
  InputDecoration _getPasswordInputDecoration(PasswordInputFieldType passwordInputFieldType) {
    if (passwordInputFieldType == PasswordInputFieldType.oldPassword) {
      return InputDecoration(
        hintText: _getPasswordInputDecorationHintText(passwordInputFieldType),
        errorText: checkCurrentPasswordValid ? null : validatorWrongPassword,
      );
    } else {
      return InputDecoration(
        hintText: _getPasswordInputDecorationHintText(passwordInputFieldType),
      );
    }
  }

  /// Returns the input hint texts for the password input fields by given [passwordInputFieldType].
  String _getPasswordInputDecorationHintText(PasswordInputFieldType passwordInputFieldType) {
    switch (passwordInputFieldType) {
      case PasswordInputFieldType.oldPassword:
        return hintTextOldPassword;
      case PasswordInputFieldType.newPassword:
        return hintTextNewPassword;
      case PasswordInputFieldType.newPasswordConfirmation:
        return hintTextConfirmNewPassword;
    }
  }
}
