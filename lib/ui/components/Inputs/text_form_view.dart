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
      this.onTouchText,
      this.isCapitalize = false});

  final TextEditingController textController;
  final String textHint;
  final bool isValidText;
  final String? errorMessage;
  bool? isPassword = false;
  bool? autofocus = false;
  bool isCapitalize = false;
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
          textCapitalization: _getCapitalizeByFlag(),
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
              Container(
                child: Assets.images.alert.image(),
              ),
              SizedBox(width: SpookerSize.m20),
              Container(
                alignment: Alignment.topCenter,
                child: Text(
                  getErrorMessage(),
                  textAlign: TextAlign.left,
                  style: SpookerFonts.s16RegularRed,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  String getErrorMessage() {
    if (this.errorMessage == null) {
      return SpookerStrings.EMPTY;
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
      return SpookerFonts.s14RegularDark;
    } else {
      if (errorMessage.isNotEmpty && !isValid) {
        return SpookerFonts.s18RegularRed;
      } else {
        return SpookerFonts.s14RegularDark;
      }
    }
  }

  TextCapitalization _getCapitalizeByFlag() {
    if (isCapitalize) {
      return TextCapitalization.sentences;
    } else {
      return TextCapitalization.none;
    }
  }
}
