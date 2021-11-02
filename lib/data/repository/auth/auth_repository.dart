import 'package:firebase_auth/firebase_auth.dart';
import 'package:spooker/data/model/result.dart';

abstract class AuthRepository {
  Future<Result<User?>> signIn();
  Future<Result<void>> signOut();
}
