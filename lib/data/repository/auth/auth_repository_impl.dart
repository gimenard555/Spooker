import 'package:spooker/data/model/result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spooker/data/remote/auth/auth_data_source.dart';
import 'package:spooker/data/repository/auth/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._dataSource);
  final AuthDataSource _dataSource;
  @override
  Future<Result<User?>> signIn() {
    return Result.guardFuture(() => _dataSource.signIn());
  }

  @override
  Future<Result<void>> signOut() {
    return Result.guardFuture(() => _dataSource.signOut());
  }
}
