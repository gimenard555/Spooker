import 'package:firebase_auth/firebase_auth.dart';

import '../../model/user.dart';

abstract class AuthDataSource {
  Future<User> signIn(String email, String password);

  Future<User?> googleSignIn();

  Future<void> signOut();

  Future<bool> isSignedAny();

  Future<bool> createAccount(SpookerUser user);

  Future<bool> isSomeoneSignIn();

  Future<SpookerUser> getMyUserInfo();

  Future<SpookerUser> getUserInfo(String profileId);

  Future<void> resetMyPassword(String email);

  Future<void> updateMyPassword(String lastPassword, String newPassword);
}
