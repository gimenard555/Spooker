import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/data/repository/auth/auth_repository.dart';
import 'package:spooker/data/repository/auth/auth_repository_impl.dart';
import 'auth_data_source_provider.dart';

final authRepositoryProvider = Provider<AuthRepository>(
    (ref) => AuthRepositoryImpl(ref.read(authDataSourceProvider)));
