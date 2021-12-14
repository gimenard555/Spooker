import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';

@immutable
class TextFormView extends HookConsumerWidget {
  TextFormView(
      {required this.textController,
      required this.textHint,
      required this.errorMessage,
      required this.isValidText,
      this.autofocus});

  final TextEditingController textController;
  final String textHint;
  final bool isValidText;
  final String errorMessage;
  bool? autofocus = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        TextFormField(
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
        SizedBox(height: SpookerSize.miniSizedBox),
        Visibility(
            visible: errorMessage.isNotEmpty,
            child: Row(
              children: [
                SvgPicture.asset('svgs/alert_icon.svg',
                    height: 25, width: 25, color: Colors.red),
                SizedBox(width: SpookerSize.miniSizedBox),
                Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      errorMessage,
                      textAlign: TextAlign.center,
                      style: SpookerFonts.errorText,
                    )),
              ],
            ))
      ],
    );
  }

  Color getDecorationByError(String errorMessage, bool isValid) {
    var borderColor;
    if (errorMessage.isEmpty && isValid) {
      borderColor = SpookerColors.spookerGreen;
    } else if (errorMessage.isNotEmpty && !isValid) {
      borderColor = SpookerColors.errorRed;
    } else {
      borderColor = SpookerColors.darkGray;
    }
    return borderColor;
  }

  TextStyle getTextStyleByText(String errorMessage, bool isValid) {
    if (errorMessage.isNotEmpty && !isValid) {
      return SpookerFonts.textFormError;
    } else {
      return SpookerFonts.textFormNormal;
    }
  }
}
