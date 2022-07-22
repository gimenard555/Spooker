import 'package:firebase_auth/firebase_auth.dart';
import 'package:spooker/data/model/result.dart';

abstract class AuthRepository {
  Future<Result<User>> signIn(String email, String password);
  Future<Result<User?>> googleSignIn();
  Future<Result<void>> signOut();
  Future<Result<bool>> isSignedAny();
}
