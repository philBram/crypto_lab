import 'package:crypto_lab/model/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseInstanceManager {
  static final FirebaseInstanceManager _instance =
      FirebaseInstanceManager._internal();

  factory FirebaseInstanceManager() => _instance;

  FirebaseInstanceManager._internal();

  void createNewUserDocument() {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore.instance.collection('users').doc(userId!).set({});
  }

  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  DocumentReference getCurrentUserDocument(String? uid) {
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

  void deleteFavoriteCoin(String? coinName) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('coins_favorites')
        .doc(coinName ?? 'not found')
        .delete();
  }

  void addFavoriteCoin(String? coinName, Crypto crypto) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('coins_favorites')
        .doc(coinName ?? 'not found')
        .set({'coin_json': crypto.toJson()});
  }

  Future<List<String>> getFavoriteCoins() async {
    List<String> favCoins = [];

    // cant use FirebaseInstanceManager here
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('coins_favorites')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        favCoins.add(result.data()['coin_json']['name']);
      });
    });

    return Future.value(favCoins);
  }
}
