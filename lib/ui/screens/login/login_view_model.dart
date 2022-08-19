import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/data/repository/auth/auth_repository.dart';
import 'package:spooker/ui/utils/strings_extensions.dart';
import 'package:spooker/ui/utils/strings_types.dart';

import '../../../data/provider/top_provider.dart';

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

  bool _isRecoveryEmail = false;

  bool get isRecoveryEmail => _isRecoveryEmail;

  bool _isRecoverySuccess = false;

  bool get isRecoverySuccess => _isRecoverySuccess;

  String _password = '';
  String _email = '';
  String _recoveryEmail = '';
  String? _recoveryErrorMessage;

  String? get recoveryErrorMessage => _recoveryErrorMessage;

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

  void validateRecoveryEmail(String text) {
    _recoveryEmail = text;
    _recoveryErrorMessage = text.validateErrorText(TextType.IS_EMAIL);
    if (_recoveryErrorMessage!.isNotEmpty) {
      _isRecoveryEmail = false;
      notifyListeners();
    } else {
      _isRecoveryEmail = true;
      notifyListeners();
    }
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
      if (user.isSuccess) {
        _loginError = '';
        user.ifSuccess((data) => {_user = data});
        notifyListeners();
      } else if (user.isFailure) {
        user.ifFailure((data) {
          _loginError = data.message;
          notifyListeners();
        });
      }
    });
  }

  Future<void> googleSignIn() async {
    return await _repository.googleSignIn().then((user) {
      if (user.isSuccess) {
        _loginError = '';
        user.ifSuccess((data) => {_user = data});
        notifyListeners();
      } else if (user.isFailure) {
        user.ifFailure((data) {
          _loginError = data.message;
          notifyListeners();
        });
      }
    });
  }

  Future<bool> isSomeoneSignIn() async {
    var isSomeone = false;
    await _repository.isSignedAny().then((value) {
      if (value.isSuccess) {
        value.ifSuccess((data) => isSomeone = data);
        notifyListeners();
      } else if (value.isFailure) {
        value.ifFailure((data) => isSomeone = false);
        notifyListeners();
      }
    });
    return isSomeone;
  }

  Future<void> recoverPassword() async {
    await _repository.resetMyPassword(_recoveryEmail).then((value) {
      if (value.isSuccess) {
        _isRecoverySuccess = true;
        notifyListeners();
      } else if (value.isFailure) {
        _isRecoverySuccess = false;
        notifyListeners();
      }
    });
  }
}
