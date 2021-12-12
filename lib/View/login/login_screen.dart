import 'package:crypto_lab/Controller/route_manager.dart';
import 'package:crypto_lab/View/crypto_lab_colors.dart';
import 'package:crypto_lab/View/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:crypto_lab/View/login/authentication_service.dart';

class LoginScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Crypto-Lab',
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
              'Bitte geben Sie Ihre E-Mail ein zum Verschicken eines Reset-Links und drücken Sie auf bestätigen.',
          recoverPasswordSuccess: 'E-Mail erfoglreich versendet',
          resendCodeButton: 'Code erneut senden',
          confirmationCodeHint: 'Bestätigungs-Code',
          confirmSignupButton: 'Bestätigen',
          confirmSignupIntro:
              'Der Code zur Authentifizierung wurde an Deine angegebene E-Mail verschickt. Bitte gebe den Code ein, um die Authentifizierung abzuschließen.',
          confirmSignupSuccess: ''),
      theme: LoginTheme(
        accentColor: Colors.blue,
        pageColorDark: Colors.grey,
        pageColorLight: Colors.amber,
        primaryColor: Colors.red,
      ),
      onLogin: (loginData) async {
        try {
          await loginUser(loginData);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Login erfolgreich!"),
              backgroundColor: Colors.green,
            ),
          );
          RouteManager().navigateToRoute(context, "/home");
        } on Exception catch (e) {
          return ("Login fehlgeschlagen: " + e.toString().replaceAll("Exception: ", ""));
        }
      },
      onSignup: (signupData) async {
        try {
          await registerUser(signupData);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Registrierung erfolgreich!"),
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
      onRecoverPassword: (email) {
        // TODO
      },
    );
  }

  Future<void> registerUser(SignupData signupData) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: signupData.name!,
        password: signupData.password!,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak password') {
        throw Exception("Das Passwort ist zu schwach.");
      } else if (e.code == 'email-already-in-use') {
        throw Exception("Dieser Account existiert bereits!");
      } else {
        throw Exception("Unbekannter Fehler");
      }
    } on Exception catch (e) {
      throw Exception("Error: " + e.toString().replaceAll("Exception: ", ""));
    }
  }

  Future<void> loginUser(LoginData loginData) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginData.name,
        password: loginData.password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception("Es konnte kein passender User gefunden werden!");
      } else if (e.code == 'wrong-password') {
        throw Exception("Falsches Passwort für diesen Nutzer!");
      } else {
        throw Exception("Unbekannter Fehler");
      }
    } on Exception catch (e) {
      throw Exception("Error: " + e.toString().replaceAll("Exception: ", ""));
    }
  }
}
