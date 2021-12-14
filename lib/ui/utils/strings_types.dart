import 'package:spooker/ui/utils/spooker_strings.dart';

enum TextType { IS_EMAIL, IS_PASSWORD, IS_DATE, IS_NORMAL_TEXT }

extension TextTypeExtension on TextType {
  String? get errorMessage {
    switch (this) {
      case TextType.IS_EMAIL:
        return SpookerErrorStrings.emailErrorText;
      case TextType.IS_PASSWORD:
        return SpookerErrorStrings.passwordErrorText;
      case TextType.IS_DATE:
        return SpookerErrorStrings.dateErrorText;
      case TextType.IS_NORMAL_TEXT:
        return null;
    }
  }
}
