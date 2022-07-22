import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/data/repository/auth/auth_repository.dart';
import 'package:spooker/ui/utils/strings_extensions.dart';
import 'package:spooker/ui/utils/strings_types.dart';

import '../../../data/model/result.dart';
import '../../../data/provider/top_provider.dart';
import '../../../data/repository/event/event_repository.dart';

final loginViewModelProvider = ChangeNotifierProvider(
    (ref) => LoginViewModel(ref.read(authRepositoryProvider)));

class LoginViewModel extends ChangeNotifier {
  LoginViewModel(this._repository);

  //Repository
  final AuthRepository _repository;

  ///Validations
  String? _errorMessage;

  String? get errorMessage => _errorMessage;
  bool _isDataComplete = false;

  bool get isDataComplete => _isDataComplete;

  String _password = '';
  String _email = '';

  //Data
  User? _user;

  User? get user => _user;
  String _loginError = '';

  //Password validations
  void validatePassword(String pass) {
    _password = pass;
    validateForm();
  }

  bool isValidPass() {
    return _password.isNotEmpty;
  }

  //Email validations
  bool isValidText() {
    if (_errorMessage == null) {
      return false;
    } else {
      return _errorMessage!.isEmpty;
    }
  }

  void isTextAvailable(String text, TextType textType) {
    _email = text;
    _errorMessage = text.validateErrorText(textType);
    validateForm();
  }

  //Final data validation
  void validateForm() {
    if (_email.isNotEmpty && _password.isNotEmpty) {
      _isDataComplete = true;
    } else {
      _isDataComplete = false;
    }
    notifyListeners();
  }

  //Events
  Future<void> signIn() async {
    return await _repository.signIn(_email, _password).then((user) {
      if (user.isFailure) {
        user.ifFailure((data) {
          _loginError = data.message;
          notifyListeners();
        });
      } else {
        user.ifSuccess((data) {
          _user = data;
          notifyListeners();
        });
      }
    });
  }

  Future<bool> isSomeoneSignIn() async { return true;}
}
