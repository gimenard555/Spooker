import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/components/Inputs/text_form_state.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';
import 'package:spooker/ui/utils/strings_types.dart';

class TextFormView extends HookConsumerWidget {
  TextFormView(
      {required this.textController,
      required this.textHint,
      this.autofocus,
      this.textType});

  TextEditingController textController;
  String textHint;
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
          decoration: getDecorationByText(state.error),
          style: getTextStyleByText(state.error),
          controller: textController,
          onChanged: (text) => state.validateTypeError(text),
        ),
        SizedBox(width: SpookerSize.sizedBoxSpace),
        Row(
          children: [
            SvgPicture.asset('svgs/alert_icon.svg',
                height: 20, width: 20, color: Colors.red),
            SizedBox(height: SpookerSize.miniSizedBox),
            Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Try entering a valid email',
                  textAlign: TextAlign.center,
                  style: SpookerFonts.titleText,
                )),
          ],
        )
      ],
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
        borderColor = SpookerColors.darkGray;
        break;
    }
    return InputDecoration(
      labelText: this.textHint,
      fillColor: borderColor,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SpookerSize.borderRadius),
        borderSide: BorderSide(
          color: borderColor,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SpookerSize.borderRadius),
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
