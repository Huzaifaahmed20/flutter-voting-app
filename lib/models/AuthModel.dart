import 'package:scoped_model/scoped_model.dart';
// import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthModel extends Model {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;
  bool loading = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<FirebaseUser> get isAuth {
    final Stream<FirebaseUser> user = _auth.onAuthStateChanged;
    return user;
  }

  void startLoader() {
    loading = true;
    notifyListeners();
  }

  void stopLoader() {
    loading = false;
    notifyListeners();
  }

  Future<FirebaseUser> handleSignUp(String name, String email, String password) async {
    try {
      final FirebaseUser registeredUser =
          (await _auth.createUserWithEmailAndPassword(email: email, password: password)).user;

      await _db.collection('users').add({'email': email, 'name': name});

      return registeredUser;
    } catch (error) {
      throw new AuthException(error.code, error.message);
    }
  }

  Future<void> handleLogin(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      notifyListeners();
      return;
    } catch (error) {
      throw AuthException(error.code, error.message);
    }
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut();
      notifyListeners();
    } catch (error) {
      print('ERROR====> $error');
      throw AuthException(error.code, error.message);
    }
  }

  Future<void> handleGoogleSignup() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    AuthResult result = (await _auth.signInWithCredential(credential));
    print(result);
  }
}
