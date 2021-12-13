import 'package:crypto_lab/Controller/route_manager.dart';
import 'package:crypto_lab/View/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'authentication_service.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      //title: 'Crypto-Lab',
      logo: 'assets/images/logo_white_simple.png',
      passwordValidator: (password) {
        if (password == null || password.length < 6) {
          return 'Passwort ist nicht lang genug! (mind. 6 Zeichen)';
        } else {
          return null;
        }
      },
      messages: LoginMessages(
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
      ),
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ));
      },
      theme: LoginTheme(
        accentColor: Colors.white,
        pageColorDark: Colors.grey,
        pageColorLight: Colors.deepPurple,
        primaryColor: Colors.deepPurple,
        logoWidth: 1,
      ),
      onLogin: (loginData) async {
        try {
          await AuthenticationService().loginUser(loginData);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Anmeldung erfolgreich!"),
              backgroundColor: Colors.green,
            ),
          );
          RouteManager().navigateToRoute(context, "/home");
        } on Exception catch (e) {
          return ("Anmeldung fehlgeschlagen: " + e.toString().replaceAll("Exception: ", ""));
        }
      },
      onSignup: (signupData) async {
        try {
          await AuthenticationService().registerUser(signupData);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Registrierung erfolgreich! Du kannst Dich nun mit den Daten anmelden."),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
        } on Exception catch (e) {
          return ("Registrierung fehlgeschlagen: " + e.toString().replaceAll("Exception: ", ""));
        }
      },
      onRecoverPassword: (email) async {
        try {
          await AuthenticationService().sendPasswordResetEmail(email);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  "Es wurde eine Mail an die angegebene E-Mail-Adresse zum Zurücksetzen des Passwortes geschickt!"),
              backgroundColor: Colors.green,
            ),
          );
        } on Exception catch (e) {
          return (e.toString().replaceAll("Exception: ", ""));
        }
      },
      loginProviders: [
        LoginProvider(
          icon: FontAwesomeIcons.bitcoin,
          label: 'Anonym',
          callback: () async {
            try {
              await AuthenticationService().signInAnonymously();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Anmeldung erfolgreich!"),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
              return null;
            } on Exception catch (e) {
              return ("Anmeldung fehlgeschlagen: " + e.toString().replaceAll("Exception: ", ""));
            }
          },
        )
      ],
    );
  }
}
