import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/data/provider/auth/auth_repository_provider.dart';
import 'package:spooker/data/repository/auth/auth_repository.dart';
import 'package:spooker/ui/utils/strings_extensions.dart';
import 'package:spooker/ui/utils/strings_types.dart';

final loginViewModel = ChangeNotifierProvider(
    (ref) => LoginViewModel(ref.read(authRepositoryProvider)));

class LoginViewModel extends ChangeNotifier {
  LoginViewModel(this._authRepository);
  final AuthRepository _authRepository;

  firebase.User? _user;
  firebase.User? get user => _user;

  ///Validations
  TextType textType = TextType.IS_NORMAL_TEXT;
  String _errorMessage = '';
  bool _isValidText = false;

  String get errorMessage => _errorMessage;
  bool get isValidText => _isValidText;

  void isTextAvailable(String text) {
    print(text);
    if (text.isEmpty) {
      _errorMessage = '';
    } else {
      switch (textType) {
        case TextType.IS_EMAIL:
          _isValidText = text.isValidEmail();
          break;
        case TextType.IS_PASSWORD:
          _isValidText = text.isValidPassword();
          break;
        case TextType.IS_DATE:
          _isValidText = text.isValidDate();
          break;
        case TextType.IS_NORMAL_TEXT:
          _isValidText = true;
          break;
      }
      validateErrorMessage();
    }
    notifyListeners();
  }

  void validateErrorMessage() {
    if (!_isValidText) {
      _errorMessage = textType.errorMessage!;
    }
  }

  ///Actions

  bool get isAuthenticated => _user != null;

  Future<void> signIn() {
    return _authRepository.signIn().then((result) {
      // Result use case No.2
      result.ifSuccess((data) {
        _user = data;
        notifyListeners();
      });
    });
  }

  Future<void> signOut() {
    return _authRepository.signOut().then((result) {
      return result.when(
          success: (_) {
            _user = null;
            notifyListeners();
          },
          failure: (_) => result);
    });
  }
}
