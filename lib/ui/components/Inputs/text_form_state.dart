import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/utils/strings_extensions.dart';
import 'package:spooker/ui/utils/strings_types.dart';

final textFormStateProvider = ChangeNotifierProvider((ref) => TextFormState());

enum ErrorStatus { Error, Right, Empty }

class TextFormState extends ChangeNotifier {
  TextType textType = TextType.IS_NORMAL_TEXT;
  String _errorMessage = '';
  bool _isValidText = false;

  String get errorMessage => _errorMessage;
  bool get isValidText => _isValidText;

  void validateText(String text) {
    if (text.isEmpty) {
      _errorMessage = '';
    } else {
      switch (textType) {
        case TextType.IS_EMAIL:
          _isValidText = text.isValidEmail();
          if (!_isValidText) {
            _errorMessage = textType.errorMessage;
          } else {
            _errorMessage = '';
          }
          break;
      }
    }
    notifyListeners();
  }
}
