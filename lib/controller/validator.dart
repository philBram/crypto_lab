import 'package:crypto_lab/view/globals.dart';

class Validator {
  /// Validator-Singleton
  static final Validator _instance = Validator._internal();

  factory Validator() => _instance;

  Validator._internal();

  String? validateEmail(String? emailInput) {
    if (emailInput!.isEmpty) {
      return "E-Mail ist erforderlich.";
    }

    /// https://html.spec.whatwg.org/multipage/input.html#e-mail-state-%28type=email%29
    if (!emailInput.contains(RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$"))) {
      return "Keine valide E-Mail.";
    }
    return null;
  }

  String? validatePassword(String? passwordInput) {
    if (passwordInput == null || passwordInput.length < 8) {
      return validatorPasswordTooShort;
    }
    if (!passwordInput.contains(RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"))) {
      return validatorPasswordUnsafe;
    } else {
      return null;
    }
  }

  String? validatePositiveNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Bitte etwas eingeben!";
    } else if (!value.contains(RegExp(r"^[+]?([0-9]+(?:[\.][0-9]*)?|\.[0-9]+)$"))) {
      return "Kein valider Wert!";
    }
    return null;
  }
}
