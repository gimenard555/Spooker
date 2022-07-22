import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spooker/data/remote/auth/auth_data_source.dart';

class AuthDataSourceImpl implements AuthDataSource {
  AuthDataSourceImpl(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  @override
  Future<User?> googleSignIn() async {
    final account = await GoogleSignIn().signIn();
    if (account == null) {
      return throw StateError('User cancel signIn');
    }
    final auth = await account.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: auth.idToken, accessToken: auth.accessToken);
    final credential = await _firebaseAuth.signInWithCredential(authCredential);
    final currentUser = _firebaseAuth.currentUser;
    assert(credential.user?.uid == currentUser?.uid);
    return credential.user;
  }

  @override
  Future<void> signOut() {
    return GoogleSignIn()
        .signOut()
        .then((_) => _firebaseAuth.signOut())
        .catchError((error) {
      debugPrint(error.toString());
      throw error;
    });
  }

  @override
  Future<User> signIn(String email, String password) async {
    try {
      UserCredential credential;
      credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final currentUser = _firebaseAuth.currentUser;
      assert(credential.user?.uid == currentUser?.uid);
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> isSignedAny() async {
    return FirebaseAuth.instance.currentUser != null;
  }
}
