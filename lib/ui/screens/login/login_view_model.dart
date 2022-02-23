import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/data/repository/auth/auth_repository.dart';
import 'package:spooker/ui/utils/strings_extensions.dart';
import 'package:spooker/ui/utils/strings_types.dart';

import '../../../data/provider/top_provider.dart';
import '../../../data/repository/event/event_repository.dart';

final loginViewModel = ChangeNotifierProvider(
    (ref) => LoginViewModel(ref.read(authRepositoryProvider)));

class LoginViewModel extends ChangeNotifier {
  LoginViewModel(this._repository);

  //Repository
  final AuthRepository _repository;

  ///Validations
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String _password = '';
  String _email = '';

  //Data
  User? _user;
  User? get user => _user;

  void validatePassword(String pass) {
    _password = pass;
    notifyListeners();
  }

  bool isValidPass() {
    return _password.isNotEmpty;
  }

  bool isValidText() {
    if (_errorMessage == null) {
      return false;
    } else {
      if (_errorMessage!.isEmpty) {
        return true;
      } else {
        return false;
      }
    }
  }

  bool isDataComplete() {
    if (_email.isNotEmpty && _password.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void isTextAvailable(String text, TextType textType) {
    _email = text;
    _errorMessage = text.validateErrorText(textType);
    notifyListeners();
  }

  Future<void> signIn() {
    return _repository.signIn().then((result) {
      // Result use case No.2
      result.ifSuccess((data) {
        _user = data;
        notifyListeners();
      });
    });
  }

  void getAllEvents(){

  }
}
