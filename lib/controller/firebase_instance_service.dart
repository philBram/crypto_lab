import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseInstanceManager {
  static final FirebaseInstanceManager _instance =
      FirebaseInstanceManager._internal();

  factory FirebaseInstanceManager() => _instance;

  FirebaseInstanceManager._internal();

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
}
