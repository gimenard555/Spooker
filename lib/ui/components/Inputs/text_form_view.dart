import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/gen/assets.gen.dart';
import 'package:spooker/ui/components/spooker_borders.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';
import 'package:spooker/ui/utils/spooker_strings.dart';

typedef WhenPressTextForm = void Function();

// ignore: must_be_immutable
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
       TextFormField(
            onTap: () {
              if (onTouchText != null) {
                onTouchText!();
              }
            },
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
                borderRadius: SpookerBorders.m30Border,
                borderSide: BorderSide(
                  color: getDecorationByError(errorMessage, isValidText),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: SpookerBorders.m30Border,
                borderSide: BorderSide(
                  color: getDecorationByError(errorMessage, isValidText),
                  width: SpookerSize.m3,
                ),
              ),
            ),
            style: getTextStyleByText(errorMessage, isValidText),
            controller: textController,
          ),
        SizedBox(height: SpookerSize.m8),
        Visibility(
            visible: getAvailable(errorMessage),
            child: Row(
              children: [
                Assets.svgs.alertIcon
                    .svg(height: SpookerSize.m14, width: SpookerSize.m14),
                SizedBox(width: SpookerSize.m8),
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
      return SpookerStrings.emptyString;
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
