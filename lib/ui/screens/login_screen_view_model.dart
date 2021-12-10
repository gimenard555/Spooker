import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final loginViewModel = Provider((ref) {
  return LoginViewModel();
});

class LoginViewModel extends ChangeNotifier {}
