import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';

typedef WhenPressTextForm = void Function();

@immutable
class TextFormView extends HookConsumerWidget {
  TextFormView(
      {required this.textController,
      required this.textHint,
      required this.errorMessage,
      required this.isValidText,
      this.autofocus,
      this.isPassword,
      this.onTouchText});

  final TextEditingController textController;
  final String textHint;
  final bool isValidText;
  final String? errorMessage;
  bool? isPassword = false;
  bool? autofocus = false;
  WhenPressTextForm? onTouchText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Focus(
            child: TextFormField(
              obscureText: this.isPassword ??= false,
              enableSuggestions: this.isPassword ??= true,
              autocorrect: this.isPassword ??= true,
              autofocus: this.autofocus ??= false,
              decoration: InputDecoration(
                labelText: this.textHint,
                labelStyle: TextStyle(
                    color: getDecorationByError(errorMessage, isValidText)),
                fillColor: SpookerColors.completeLight,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SpookerSize.borderRadius),
                  borderSide: BorderSide(
                    color: getDecorationByError(errorMessage, isValidText),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SpookerSize.borderRadius),
                  borderSide: BorderSide(
                    color: getDecorationByError(errorMessage, isValidText),
                    width: 3,
                  ),
                ),
              ),
              style: getTextStyleByText(errorMessage, isValidText),
              controller: textController,
            ),
            onFocusChange: (hasFocus) {
              if (hasFocus && onTouchText != null) {
                onTouchText!();
              }
            }),
        SizedBox(height: SpookerSize.miniSizedBox),
        Visibility(
            visible: getAvailable(errorMessage),
            child: Row(
              children: [
                SvgPicture.asset('svgs/alert_icon.svg', height: 16, width: 16),
                SizedBox(width: SpookerSize.miniSizedBox),
                Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      getErrorMessage(),
                      textAlign: TextAlign.center,
                      style: SpookerFonts.errorText,
                    )),
              ],
            ))
      ],
    );
  }

  String getErrorMessage() {
    if (this.errorMessage == null) {
      return '';
    } else {
      return errorMessage!;
    }
  }

  bool getAvailable(String? errorMessage) {
    if (errorMessage == null || errorMessage.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Color getDecorationByError(String? errorMessage, bool isValid) {
    var borderColor;
    if (errorMessage == null) {
      borderColor = SpookerColors.noAvailableColor;
    } else {
      if (errorMessage.isEmpty && isValid) {
        borderColor = SpookerColors.blueCommonTextColor;
      } else if (errorMessage.isNotEmpty && !isValid) {
        borderColor = SpookerColors.errorRed;
      } else if (errorMessage.isEmpty && !isValidText) {
        borderColor = SpookerColors.noAvailableColor;
      }
    }
    return borderColor;
  }

  TextStyle getTextStyleByText(String? errorMessage, bool isValid) {
    if (errorMessage == null) {
      return SpookerFonts.textFormNormal;
    } else {
      if (errorMessage.isNotEmpty && !isValid) {
        return SpookerFonts.textFormError;
      } else {
        return SpookerFonts.textFormNormal;
      }
    }
  }
}
