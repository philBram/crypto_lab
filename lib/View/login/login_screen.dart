import 'package:crypto_lab/View/custom_colors.dart';
import 'package:crypto_lab/View/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:crypto_lab/View/login/authentication_service.dart';

const users = const {
  'hallowelt@hallo.com': '123456',
};

class LoginScreen extends StatelessWidget{
  FirebaseAuth auth = FirebaseAuth.instance;
  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  Future<String?>? _onLoginAuth(LoginData data){
    return AuthenticationService(FirebaseAuth.instance).signIn(email: data.name, password: data.password);

  }

  Future<String?>? _onSignUpAuth(SignupData data){
    return AuthenticationService(FirebaseAuth.instance).signUp(email: data.name, password: data.password);
  }

  Future<String?>? _onRecoverPassword(SignupData data){
    return AuthenticationService(FirebaseAuth.instance).recoverPassword(password: data.password);
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
        onLogin: AuthenticationService(FirebaseAuth.instance).signIn(email: data.name, password: data.password),
        onSignup: _onSignUpAuth,
        onRecoverPassword: _onRecoverPassword,
      onSubmitAnimationCompleted: (){
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => HomeScreen())
        );
        onLogin: (LoginData){
          return _onLoginAuth(LoginData);
        };
      },
    );
  }


}



