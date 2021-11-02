import 'package:hooks_riverpod/all.dart';
import 'package:spooker/data/local/app_shared_preferences.dart';

final preferencesProvider =
    Provider<AppSharedPreferences>((ref) => AppSharedPreferences());
