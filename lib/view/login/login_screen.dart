import 'package:crypto_lab/controller/firebase_instance_service.dart';
import 'package:crypto_lab/controller/validator.dart';
import 'package:crypto_lab/view/home/home_screen.dart';
import 'package:crypto_lab/view/widgets/custom_colors.dart';
import 'package:crypto_lab/view/widgets/custom_snackbar.dart';
import 'package:crypto_lab/controller/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../globals.dart';
import 'custom_login_messages.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      //title: 'Crypto-Lab',
      logo: 'assets/images/logo_white_simple2.png',
      passwordValidator: (password) => Validator().validatePassword(password),
      userValidator: (email) => Validator().validateEmail(email),
      messages: CustomLoginMessages.getLoginMessages(),
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ));
      },
      theme: LoginTheme(
        accentColor: Colors.white,
        bodyStyle: const TextStyle(backgroundColor: Colors.white),
        pageColorDark: Colors.grey,
        pageColorLight: Color(CustomColors.cryptoLabBackgroundPrimaryValue),
        primaryColor: Color(CustomColors.cryptoLabBackgroundPrimaryValue),
        logoWidth: 1,
      ),
      onLogin: (loginData) async {
        try {
          await AuthenticationService().loginUser(loginData);
          _displayLoginSuccessful(context);
        } on Exception catch (e) {
          return ("Anmeldung fehlgeschlagen: " + e.toString().replaceAll("Exception: ", ""));
        }
      },
      onSignup: (signupData) async {
        try {
          await AuthenticationService().registerUser(signupData);
          CustomSnackbar().displayTextWithTitle(
            context: context,
            status: SnackbarStatus.success,
            displayText: successSignupText,
            displayTitle: successSignupTitle,
          );

          // Add new users collection with docs containing a uid of current user
          FirebaseInstanceManager().createNewUserDocument();
          Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false);
        } on Exception catch (e) {
          return ("Registrierung fehlgeschlagen: " + e.toString().replaceAll("Exception: ", ""));
        }
      },
      onRecoverPassword: (email) async {
        try {
          await AuthenticationService().sendPasswordResetEmail(email);
          CustomSnackbar().displayText(
            context: context,
            status: SnackbarStatus.success,
            displayText: successResetPassword,
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
              _displayLoginSuccessful(context);
              return null;
            } on Exception catch (e) {
              return ("Anmeldung fehlgeschlagen: " + e.toString().replaceAll("Exception: ", ""));
            }
          },
        )
      ],
    );
  }

  void _displayLoginSuccessful(BuildContext context) {
    CustomSnackbar().displayTextWithTitle(
      context: context,
      status: SnackbarStatus.success,
      displayText: successLoginText,
      displayTitle: successLoginTitle,
    );
  }
}
