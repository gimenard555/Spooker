import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/components/Inputs/text_form_state.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';
import 'package:spooker/ui/utils/strings_types.dart';

@immutable
class TextFormView extends HookConsumerWidget {
  TextFormView(
      {required this.textController,
      required this.textHint,
      this.autofocus,
      this.textType});

  final TextEditingController textController;
  final String textHint;
  bool? autofocus = false;
  TextType? textType = TextType.IS_NORMAL_TEXT;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(textFormStateProvider);
    state.textType = this.textType ??= TextType.IS_NORMAL_TEXT;
    return Column(
      children: [
        TextFormField(
          autofocus: this.autofocus ??= false,
          decoration: InputDecoration(
            labelText: this.textHint,
            labelStyle: TextStyle(
                color: getDecorationByError(
                    state.errorMessage, state.isValidText)),
            fillColor: SpookerColors.completeLight,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(SpookerSize.borderRadius),
              borderSide: BorderSide(
                color:
                    getDecorationByError(state.errorMessage, state.isValidText),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(SpookerSize.borderRadius),
              borderSide: BorderSide(
                color:
                    getDecorationByError(state.errorMessage, state.isValidText),
                width: 3,
              ),
            ),
          ),
          style: getTextStyleByText(state.errorMessage, state.isValidText),
          controller: textController,
          onChanged: (text) => state.validateText(text),
        ),
        SizedBox(height: SpookerSize.miniSizedBox),
        Visibility(
            visible: state.errorMessage.isNotEmpty,
            child: Row(
              children: [
                SvgPicture.asset('svgs/alert_icon.svg',
                    height: 25, width: 25, color: Colors.red),
                SizedBox(width: SpookerSize.miniSizedBox),
                Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      state.errorMessage,
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
