import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanages => _firebaseAuth.authStateChanges();

  Future<String?> signIn({required String email, required String password}) async {
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed in:";
    } on FirebaseAuthException catch (e){
      return e.message;
    }
  }

  Future<String?> signUp({required String email, required String password}) async{
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return "Signed up:";
    } on FirebaseAuthException catch (e){
      return e.message;
    }
  }

  Future<String?>recoverPassword({required String password}) async{
    try{
      await _firebaseAuth.currentUser!.updatePassword(password);
      return "Password updated";
    }on FirebaseException catch(e){
      return e.message;
    }
  }

  Future<void> signOut() async{
    await _firebaseAuth.signOut();
  }
}