import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/components/Inputs/text_form_state.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';
import 'package:spooker/ui/utils/strings_types.dart';

class TextFormView extends HookWidget {
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
  Widget build(BuildContext context) {
    final state = useProvider(textFormStateProvider);
    state.textType = this.textType ??= TextType.IS_NORMAL_TEXT;
    return TextFormField(
      autofocus: this.autofocus ??= false,
      decoration: getDecorationByText(state.error),
      style: getTextStyleByText(state.error),
      controller: textController,
      onChanged: (text) => state.validateTypeError(text),
    );
  }

  InputDecoration getDecorationByText(TextFormError textFormError) {
    var borderColor;
    switch (textFormError) {
      case TextFormError.RIGHT:
        borderColor = SpookerColors.spookerGreen;
        break;
      case TextFormError.WRONG:
        borderColor = SpookerColors.errorRed;
        break;
      case TextFormError.NORMAL:
        borderColor = SpookerColors.lightGray;
        break;
      case TextFormError.EMPTY:
        borderColor = SpookerColors.lightGray;
        break;
    }
    return InputDecoration(
      labelText: this.textHint,
      fillColor: borderColor,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          color: borderColor,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          color: borderColor,
          width: 2.0,
        ),
      ),
    );
  }

  TextStyle getTextStyleByText(TextFormError textFormError) {
    var textStyle;
    switch (textFormError) {
      case TextFormError.RIGHT:
        textStyle = SpookerFonts.textFormNormal;
        break;
      case TextFormError.WRONG:
        textStyle = SpookerFonts.textFormError;
        break;
      case TextFormError.NORMAL:
        textStyle = SpookerFonts.textFormNormal;
        break;
      case TextFormError.EMPTY:
        textStyle = SpookerFonts.textFormHint;
        break;
    }
    return textStyle;
  }
}
