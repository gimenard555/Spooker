import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/utils/strings_types.dart';

final textFormStateProvider = ChangeNotifierProvider((ref) => TextFormState());

class TextFormState extends ChangeNotifier {
  TextFormError error = TextFormError.EMPTY;
  TextType textType = TextType.IS_NORMAL_TEXT;

  void validateTypeError(String text) {
    if (text.isEmpty) {
      error = TextFormError.EMPTY;
    } else {
      switch (textType) {
        case TextType.IS_EMAIL:
          error = _validateIsEmail(text);
          break;
        case TextType.IS_PASSWORD:
          error = _validateIsPassword(text);
          break;
        case TextType.IS_DATE:
          error = _validateIsDate(text);
          break;
        case TextType.IS_NORMAL_TEXT:
          error = TextFormError.NORMAL;
          break;
      }
    }
    notifyListeners();
  }

  TextFormError _validateIsEmail(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (emailValid) {
      return TextFormError.RIGHT;
    } else {
      return TextFormError.WRONG;
    }
  }

  TextFormError _validateIsPassword(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (emailValid) {
      return TextFormError.RIGHT;
    } else {
      return TextFormError.WRONG;
    }
  }

  TextFormError _validateIsDate(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (emailValid) {
      return TextFormError.RIGHT;
    } else {
      return TextFormError.WRONG;
    }
  }
}

enum TextFormError { RIGHT, WRONG, NORMAL, EMPTY }
