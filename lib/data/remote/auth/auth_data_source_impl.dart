import 'package:encrypt/encrypt.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spooker/data/remote/auth/auth_data_source.dart';
import 'package:spooker/ui/utils/spooker_strings.dart';

import '../../local/app_shared_preferences.dart';
import '../../model/user.dart';
import '../FirestoreConstants.dart';

class AuthDataSourceImpl implements AuthDataSource {
  AuthDataSourceImpl(
      this._firebaseAuth, this._firebaseFirestore, this._preferences);

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final AppSharedPreferences _preferences;

  @override
  Future<User?> googleSignIn() async {
    final account = await GoogleSignIn().signIn();
    if (account == null) {
      return throw StateError(SpookerStrings.googleStateError);
    }
    final auth = await account.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: auth.idToken, accessToken: auth.accessToken);
    final credential = await _firebaseAuth.signInWithCredential(authCredential);
    final currentUser = _firebaseAuth.currentUser;
    assert(credential.user?.uid == currentUser?.uid);
    await _saveUserLocal();
    return credential.user;
  }

  Future<void> _saveUserLocal() async {
    final prefs = await _preferences.getInstance();
    final myUser = await getMyUserInfo();
    prefs.setString(FirestoreConstants.birthdate, myUser.birthdate);
    prefs.setString(FirestoreConstants.email, myUser.emailAddress);
    prefs.setString(FirestoreConstants.imagePath, myUser.image);
    prefs.setString(FirestoreConstants.name, myUser.name);
    prefs.setString(FirestoreConstants.password, myUser.password);
    prefs.setString(FirestoreConstants.username, myUser.username);
    prefs.setString(FirestoreConstants.userId, myUser.id);
  }

  @override
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  @override
  Future<User> signIn(String email, String password) async {
    UserCredential credential;
    final pass = _getEncryptedPassword(password);
    credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pass);
    final currentUser = _firebaseAuth.currentUser;
    assert(credential.user?.uid == currentUser?.uid);
    await _saveUserLocal();
    return credential.user!;
  }

  @override
  Future<bool> isSignedAny() async {
    return FirebaseAuth.instance.currentUser != null;
  }

  @override
  Future<bool> createAccount(SpookerUser user) async {
    var isAuthenticated = false;
    user.password = _getEncryptedPassword(user.password);
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.emailAddress, password: user.password);
    await _firebaseFirestore
        .collection(FirestoreConstants.usersCollection)
        .add(user.toMap())
        .then((value) => {isAuthenticated = true});
    await _saveUserLocal();
    return isAuthenticated;
  }

  @override
  Future<bool> isSomeoneSignIn() async {
    var userId = '';
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      await _firebaseFirestore
          .collection(FirestoreConstants.usersCollection)
          .where(FirestoreConstants.email, isEqualTo: currentUser.email)
          .get()
          .then((querySnapshot) {
        userId = querySnapshot.docs.first.id;
      });
      return userId.isNotEmpty;
    } else {
      return false;
    }
  }

  @override
  Future<SpookerUser> getMyUserInfo() async {
    late SpookerUser user;
    final currentUser = _firebaseAuth.currentUser;
    await _firebaseFirestore
        .collection(FirestoreConstants.usersCollection)
        .where(FirestoreConstants.email, isEqualTo: currentUser!.email)
        .get()
        .then((querySnapshot) {
      user = SpookerUser.fromMap(querySnapshot.docs.first.data());
      user.id = querySnapshot.docs.first.id;
    });
    return user;
  }

  @override
  Future<void> resetMyPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> updateMyPassword(String lastPassword, String newPassword) async {
    final databaseUser = await getMyUserInfo();
    final currentUser = _firebaseAuth.currentUser;
    if (databaseUser.password == lastPassword) {
      databaseUser.password = newPassword;
      await currentUser!.updatePassword(newPassword);
    }
  }

  @override
  Future<SpookerUser> getUserInfo(String profileId) async {
    late SpookerUser user;
    await _firebaseFirestore
        .collection(FirestoreConstants.usersCollection)
        .doc(profileId)
        .get()
        .then((querySnapshot) {
      user = SpookerUser.fromMap(querySnapshot.data()!);
      user.id = querySnapshot.id;
    });
    return user;
  }

  String _getEncryptedPassword(String password) {
    final key = Key.fromUtf8(FirestoreConstants.authKeyEnc);
    final iv = IV.fromLength(FirestoreConstants.authKeyEncSize);
    final encrypter = Encrypter(AES(key));
    final encrypted = encrypter.encrypt(password, iv: iv);
    return encrypted.base64;
  }

  String _getDecryptedPassword(String encrypt) {
    final key = Key.fromUtf8(FirestoreConstants.authKeyEnc);
    final iv = IV.fromLength(FirestoreConstants.authKeyEncSize);
    final encrypter = Encrypter(AES(key));
    final decrypted = encrypter.decrypt64(encrypt, iv: iv);
    return decrypted;
  }
}
