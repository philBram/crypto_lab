import 'package:flutter_login/flutter_login.dart';

class CustomLoginMessages {
  static LoginMessages getLoginMessages() {
    return LoginMessages(
      userHint: 'E-Mail',
      passwordHint: 'Passwort',
      confirmPasswordHint: 'Passwort wiederholen',
      loginButton: 'Einloggen',
      signupButton: 'Registrieren',
      forgotPasswordButton: 'Passwort vergessen?',
      recoverPasswordButton: 'Passwort zurücksetzen',
      goBackButton: 'Zurück',
      confirmPasswordError: 'Passwörter stimmen nicht überein',
      additionalSignUpFormDescription: 'Bitte eine E-Mail wählen!',
      additionalSignUpSubmitButton: 'Bestätigen',
      recoverPasswordIntro: 'Passwort zurücksetzen',
      recoverPasswordDescription:
          'Bitte geben Sie Ihre E-Mail ein, um eine Mail zum Zurücksetzen Ihres Passwortes zu erhalten.',
      recoverPasswordSuccess: 'E-Mail zum Zurücksetzen des Passwortes erfolgreich versendet!',
      resendCodeButton: 'Code erneut senden',
      confirmationCodeHint: 'Bestätigungs-Code',
      confirmSignupButton: 'Bestätigen',
      confirmSignupIntro:
          'Der Code zur Authentifizierung wurde an Deine angegebene E-Mail verschickt. Bitte gebe den Code ein, um die Authentifizierung abzuschließen.',
      confirmSignupSuccess: '',
      confirmRecoverSuccess: 'Erfolg',
      signUpSuccess: 'Erfolgreich registriert!',
      providersTitleFirst: 'oder anonym als Gast anmelden',
      providersTitleSecond: 'Anonym',
      setPasswordButton: 'Passwort',
      resendCodeSuccess: 'Rücksetz-Code erfolgreich versendet!',
      confirmationCodeValidationError: 'Der Code konnte nicht validiert werden!',
      confirmRecoverIntro: 'Erfolg!',
      recoverCodePasswordDescription: 'Lasse Dir zum Zurücksetzen deines Passwortes einen Code zuschicken!',
      flushbarTitleError: 'Fehler',
      flushbarTitleSuccess: 'Erfolg',
      recoveryCodeHint: "Rücksetz-Code",
      recoveryCodeValidationError: "Rücksetz-Code ist leer",
    );
  }
}
