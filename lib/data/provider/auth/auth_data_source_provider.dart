import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/data/remote/auth_data_source.dart';
import 'package:spooker/data/remote/auth_data_source_impl.dart';

import '../firebase_auth_provider.dart';

final authDataSourceProvider = Provider<AuthDataSource>(
    (ref) => AuthDataSourceImpl(ref.read(firebaseAuthProvider)));
