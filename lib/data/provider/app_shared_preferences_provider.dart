import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/data/local/app_shared_preferences.dart';

final preferencesProvider = Provider((ref) {
  return AppSharedPreferences();
});
