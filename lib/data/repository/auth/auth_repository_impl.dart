import 'package:flutter/cupertino.dart';
import 'package:spooker/data/model/result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spooker/data/remote/auth/auth_data_source.dart';
import 'package:spooker/data/repository/auth/auth_repository.dart';

import '../../model/user.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._dataSource);

  final AuthDataSource _dataSource;

  @override
  Future<Result<User?>> googleSignIn() {
    return Result.guardFuture(() => _dataSource.googleSignIn());
  }

  @override
  Future<Result<void>> signOut() {
    return Result.guardFuture(() => _dataSource.signOut());
  }

  @override
  Future<Result<User>> signIn(String email, String password) {
    return Result.guardFuture(
        () => _dataSource.signIn(email.trim(), password.trim()));
  }

  @override
  Future<Result<bool>> isSignedAny() {
    return Result.guardFuture(() => _dataSource.isSignedAny());
  }

  @override
  Future<Result<bool>> createAccount(SpookerUser user) {
    return Result.guardFuture(() => _dataSource.createAccount(user));
  }

  @override
  Future<Result<bool>> getCurrentUser() {
    return Result.guardFuture(() => _dataSource.isSomeoneSignIn());
  }
}
