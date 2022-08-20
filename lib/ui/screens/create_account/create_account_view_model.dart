import 'package:flutter/widgets.dart';
import 'package:get/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/data/model/user.dart';
import 'package:spooker/ui/utils/spooker_strings.dart';
import 'package:spooker/ui/utils/strings_extensions.dart';
import 'package:spooker/ui/utils/strings_types.dart';

import '../../../data/provider/top_provider.dart';
import '../../../data/repository/auth/auth_repository.dart';

final createAccountViewModel = ChangeNotifierProvider(
    (ref) => CreateAccountViewModel(ref.read(authRepositoryProvider)));

class CreateAccountViewModel extends ChangeNotifier {
  CreateAccountViewModel(this._repository);

  final AuthRepository _repository;

  ///Validations
  String _email = SpookerStrings.EMPTY;
  String? _errorEmailMessage;

  String _wholeName = SpookerStrings.EMPTY;
  bool _isWholeName = false;

  bool get isWholeName => _isWholeName;

  set wholeName(String name) {
    _wholeName = name;
    if (_wholeName.isNotEmpty) {
      _isWholeName = true;
    } else {
      _isWholeName = false;
    }
    notifyListeners();
  }

  String? get errorEmailMessage => _errorEmailMessage;

  String _username = SpookerStrings.EMPTY;
  String? _errorUsernameMessage;

  String? get errorUsernameMessage => _errorUsernameMessage;

  String _birthdate = SpookerStrings.EMPTY;

  String get birthdate => _birthdate;

  String _password = SpookerStrings.EMPTY;
  String? _errorPasswordMessage;

  String? get errorPasswordMessage => _errorPasswordMessage;

  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  String? _errorConfirmedPasswordMessage;

  String? get errorConfirmedPasswordMessage => _errorConfirmedPasswordMessage;

  void saveBirthdate(String date) {
    _birthdate = date;
    notifyListeners();
  }

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
      _errorConfirmedPasswordMessage = SpookerStrings.EMPTY;
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
    if (_isWholeName &&
        _username.isNotEmpty &&
        _email.isNotEmpty &&
        _password.isNotEmpty &&
        _birthdate.isNotEmpty &&
        (_errorConfirmedPasswordMessage == null ||
            _errorConfirmedPasswordMessage!.isEmpty)) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> createAccount() async {
    var user =
        SpookerUser(_birthdate, _email, "", _username, _password, _username);
    return await _repository.createAccount(user).then((value) {
      if (value.isSuccess) {
        value.ifSuccess((flag) => _isAuthenticated = flag);
        notifyListeners();
      } else if (value.isFailure) {
        value.ifFailure((data) {
          _isAuthenticated = false;
          notifyListeners();
        });
      }
    });
  }
}
