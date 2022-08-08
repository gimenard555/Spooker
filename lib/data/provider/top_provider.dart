import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/data/local/app_shared_preferences.dart';
import 'package:spooker/data/remote/artwork/artwork_data_source.dart';
import 'package:spooker/data/repository/event/event_repository.dart';
import 'package:spooker/data/repository/event/event_repository_impl.dart';
import 'package:spooker/data/repository/reminder/reminder_repository.dart';
import 'package:spooker/data/repository/reminder/reminder_repository_impl.dart';
import '../remote/artwork/artwork_data_source_impl.dart';
import '../remote/auth/auth_data_source.dart';
import '../remote/auth/auth_data_source_impl.dart';
import '../remote/event/event_data_source.dart';
import '../remote/event/event_data_source_impl.dart';
import '../remote/reminder/reminder_data_source.dart';
import '../remote/reminder/reminder_data_source_impl.dart';
import '../repository/artwork/artwork_repository.dart';
import '../repository/artwork/artwork_repository_impl.dart';
import '../repository/auth/auth_repository.dart';
import '../repository/auth/auth_repository_impl.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((_) => FirebaseAuth.instance);

final firebaseStoreProvider =
    Provider<FirebaseFirestore>((_) => FirebaseFirestore.instance);

final firebaseStorageProvider =
    Provider<FirebaseStorage>((_) => FirebaseStorage.instance);

final preferencesProvider = Provider((ref) {
  return AppSharedPreferences();
});

//DataSources
final authDataSourceProvider = Provider<AuthDataSource>((ref) =>
    AuthDataSourceImpl(
        ref.read(firebaseAuthProvider), ref.read(firebaseStoreProvider)));

final eventDataSourceProvider = Provider<EventDataSource>((ref) =>
    EventDataSourceImpl(
        ref.read(firebaseStoreProvider), ref.read(firebaseAuthProvider)));

final artworkDataSourceProvider = Provider<ArtworkDataSource>((ref) =>
    ArtworkDataSourceImpl(ref.read(firebaseStoreProvider),
        ref.read(firebaseStorageProvider), ref.read(firebaseAuthProvider)));

final reminderDataSourceProvider = Provider<ReminderDataSource>((ref) =>
    ReminderDataSourceImpl(
        ref.read(firebaseStoreProvider), ref.read(firebaseAuthProvider)));

//Repositories
final authRepositoryProvider = Provider<AuthRepository>(
    (ref) => AuthRepositoryImpl(ref.read(authDataSourceProvider)));

final eventRepositoryProvider = Provider<EventRepository>(
    (ref) => EventRepositoryImpl(ref.read(eventDataSourceProvider)));

final artworkRepositoryProvider = Provider<ArtworkRepository>(
    (ref) => ArtworkRepositoryImpl(ref.read(artworkDataSourceProvider)));

final reminderRepositoryProvider = Provider<ReminderRepository>(
    (ref) => ReminderRepositoryImpl(ref.read(reminderDataSourceProvider)));
