import 'package:crypto_lab/controller/validator.dart';
import 'package:crypto_lab/view/globals.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('email validation', ()
  {
    test('empty email test', () {
      String? validatorResult = Validator().validateEmail("");
      expect(validatorResult, "E-Mail ist erforderlich.");
    });

    test('invalid email test', () {
      String? validatorResult1 = Validator().validateEmail("myMail@");
      expect(validatorResult1, "Keine valide E-Mail.");
    });

    test('valid email test', () {
      String? validatorResult1 = Validator().validateEmail("test@mail.com");
      expect(validatorResult1, null);
    });
  });

  group('password validation', ()
  {
    test('too short password test', () {
      String? validatorResult1 = Validator().validatePassword("");
      String? validatorResult2 = Validator().validatePassword("test12");
      expect(validatorResult1, validatorPasswordTooShort);
      expect(validatorResult2, validatorPasswordTooShort);
    });

    test('unsafe password test', () {
      String? validatorResult1 = Validator().validatePassword("testPassword");
      String? validatorResult2 = Validator().validatePassword("12345678");
      expect(validatorResult1, validatorPasswordUnsafe);
      expect(validatorResult2, validatorPasswordUnsafe);
    });

    test('valid password test', () {
      String? validatorResult = Validator().validatePassword("test1234");
      expect(validatorResult, null);
    });
  });

  group('positive number validation', ()
  {
    test('empty input test', () {
      String? validatorResult = Validator().validatePositiveNumber("");
      expect(validatorResult, "Bitte etwas eingeben!");
    });

    test('invalid number test', () {
      String? validatorResult1 = Validator().validatePositiveNumber("-5.5");
      String? validatorResult2 = Validator().validatePositiveNumber("abc");
      expect(validatorResult1, "Kein valider Wert!");
      expect(validatorResult2, "Kein valider Wert!");
    });

    test('valid positive number test', () {
      String? validatorResult = Validator().validatePositiveNumber("2.4");
      expect(validatorResult, null);
    });
  });
}
