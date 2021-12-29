import 'package:spooker/ui/utils/strings_types.dart';

extension StringExtensions on String? {
//Password must have minimum (1 upper case, 1 lowe case, 1 numeric, 1 special char)
//Allow common char (!@#$&*~)
  String? validateErrorText(TextType textType) {
    var regex;
    switch (textType) {
      case TextType.IS_EMAIL:
        regex =
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
        break;
      case TextType.IS_PASSWORD:
        regex =
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~.-]).{8,}$';
        break;
      case TextType.IS_DATE:
        regex = r'(\d{4}-?\d\d-?\d\d(\s|T)\d\d:?\d\d:?\d\d)';
        break;
      case TextType.IS_NORMAL_TEXT:
        regex = r'^(?!\s*$)[a-zA-Z0-9- ]{1,40}$';
        break;
    }
    if (this == null || this!.isEmpty) {
      return null;
    } else {
      if (RegExp(regex).hasMatch(this!)) {
        return '';
      } else {
        return textType.errorMessage;
      }
    }
  }
}
