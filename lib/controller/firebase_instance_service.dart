import 'package:crypto_lab/model/crypto.dart';
import 'package:crypto_lab/view/widgets/custom_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FirebaseInstanceManager {
  static final FirebaseInstanceManager _instance = FirebaseInstanceManager._internal();

  factory FirebaseInstanceManager() => _instance;

  FirebaseInstanceManager._internal();

  void createNewUserDocument() {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore.instance.collection('users').doc(userId!).set({});
  }

  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  DocumentReference getCurrentUserDocument({required String? uid}) {
    return FirebaseFirestore.instance.collection('users').doc(uid!);
  }

  CollectionReference getCurrentUserFavoriteCoinsCollection() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('coins_favorites');
  }

  bool checkAnonymousUser() {
    User? user = FirebaseAuth.instance.currentUser;
    return user == null || user.isAnonymous;
  }

  void deleteFavoriteCoin({required String? coinName, required BuildContext context}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('coins_favorites')
        .doc(coinName ?? 'not found')
        .delete();
    CustomSnackbar().displayText(
        context: context, status: SnackbarStatus.failure, displayText: '$coinName wurde aus Favoriten entfernt');
  }

  void addFavoriteCoin({required String? coinName, required Crypto crypto, required BuildContext context}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('coins_favorites')
        .doc(coinName ?? 'not found')
        .set({'coin_json': crypto.toJson()});
    CustomSnackbar().displayText(
        context: context, status: SnackbarStatus.success, displayText: '$coinName wurde zu den Favoriten hinzugefügt');
  }
}
