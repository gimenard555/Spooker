import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/data/provider/auth/auth_repository_provider.dart';
import 'package:spooker/data/repository/auth/auth_repository.dart';
import 'package:spooker/ui/utils/strings_extensions.dart';
import 'package:spooker/ui/utils/strings_types.dart';

final authViewModel = ChangeNotifierProvider(
    (ref) => CreateAccountViewModel(ref.read(authRepositoryProvider)));

class CreateAccountViewModel extends ChangeNotifier {
  CreateAccountViewModel(this._authRepository);
  final AuthRepository _authRepository;

  ///Validations
  String? _errorMessage;

  String? get errorMessage => _errorMessage;
  bool isValidText() {
    if (_errorMessage!.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  // errorMessage = null esta vacio, errorMessage = esta vacio el texto es valido, errorMessage = tiene texto el texto es invalido
  void isTextAvailable(
      {required String text, TextType textType = TextType.IS_NORMAL_TEXT}) {
    _errorMessage = text.isValidText(textType);
    notifyListeners();
  }

  void signIn() {}
}
