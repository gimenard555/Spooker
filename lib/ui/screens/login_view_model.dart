import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/utils/strings_extensions.dart';
import 'package:spooker/ui/utils/strings_types.dart';

final loginViewModel = ChangeNotifierProvider((ref) => LoginViewModel());

class LoginViewModel extends ChangeNotifier {
  ///Validations
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String _password = '';
  String _email = '';

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

  void signIn() {}
}
