import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login/flutter_login.dart';

class AuthenticationService {

  /// AuthenticationService-Singleton
  static final AuthenticationService _instance = AuthenticationService._internal();

  factory AuthenticationService() => _instance;

  AuthenticationService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInAnonymously() async {
    try {
      await _auth.signInAnonymously();
    } on Exception catch (e) {
      throw Exception("Error: " + e.toString().replaceAll("Exception: ", ""));
    }
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

  Future<void> deleteUser() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        throw Exception("Du musst dich erneut authentifizieren!");
      }
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on Exception catch(e) {
      throw Exception("Error: " + e.toString().replaceAll("Exception: ", ""));
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } on Exception catch(e) {
      throw Exception("Error: " + e.toString().replaceAll("Exception: ", ""));
    }
  }

  Future<bool> validateCurrentPassword(String password) async {
    User? user = _auth.currentUser;

    AuthCredential authCredential = EmailAuthProvider.credential(
      email: user!.email!,
      password: password,
    );
    try {
      var authResult = await user.reauthenticateWithCredential(authCredential);
      return authResult.user != null;
    } catch (e) {
      return false;
    }
  }

  Future<void> changePassword(String newPassword) async {
    await _auth.currentUser!.updatePassword(newPassword);
  }
}