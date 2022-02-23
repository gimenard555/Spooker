import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/utils/spooker_strings.dart';
import 'package:spooker/ui/utils/strings_extensions.dart';
import 'package:spooker/ui/utils/strings_types.dart';

final createAccountViewModel =
    ChangeNotifierProvider((ref) => CreateAccountViewModel());

class CreateAccountViewModel extends ChangeNotifier {
  ///Validations
  String _email = '';
  String? _errorEmailMessage;
  String? get errorEmailMessage => _errorEmailMessage;

  String _username = '';
  String? _errorUsernameMessage;
  String? get errorUsernameMessage => _errorUsernameMessage;

  String _birthdate = '';

  String _password = '';
  String? _errorPasswordMessage;
  String? get errorPasswordMessage => _errorPasswordMessage;

  String? _errorConfirmedPasswordMessage;
  String? get errorConfirmedPasswordMessage => _errorConfirmedPasswordMessage;

  void isUsernameAvaliable(String text) {
    _errorUsernameMessage = text.validateErrorText(TextType.IS_NORMAL_TEXT);
    if (text.isNotEmpty && _errorUsernameMessage == null ||
        _errorUsernameMessage!.isEmpty) {
      _username = text;
    }
    notifyListeners();
  }

  bool isValidUsername() {
    if (_errorUsernameMessage == null || _errorUsernameMessage!.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void isEmailAvaliable(String text) {
    _errorEmailMessage = text.validateErrorText(TextType.IS_EMAIL);
    if (text.isNotEmpty && _errorEmailMessage == null ||
        _errorEmailMessage!.isEmpty) {
      _email = text;
    }
    notifyListeners();
  }

  bool isValidEmail() {
    if (_errorEmailMessage == null || _errorEmailMessage!.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void isPasswordAvaliable(String text) {
    _errorPasswordMessage = text.validateErrorText(TextType.IS_PASSWORD);
    if (text.isNotEmpty && _errorPasswordMessage == null ||
        _errorPasswordMessage!.isEmpty) {
      _password = text;
    }
    notifyListeners();
  }

  bool isValidPassword() {
    if (_errorPasswordMessage == null || _errorPasswordMessage!.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void isConfirmedPasswordAvaliable(String text) {
    if (_password != text) {
      _errorConfirmedPasswordMessage = SpookerErrorStrings.passwordMatch;
    } else {
      _errorConfirmedPasswordMessage = '';
    }
    notifyListeners();
  }

  bool isValidConfirmedPass() {
    if (_errorConfirmedPasswordMessage == null ||
        _errorConfirmedPasswordMessage!.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool isDataCompleted() {
    if (_username.isNotEmpty &&
        _email.isNotEmpty &&
        _password.isNotEmpty &&
        _birthdate.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void createAccount() {}
}
