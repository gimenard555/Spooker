import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';

typedef SelectedText = void Function();

class CustomTextTitle extends HookConsumerWidget {
  CustomTextTitle({required this.titleText, this.highlight = true, this.selectedText});

  final String titleText;
  bool highlight = true;
  SelectedText? selectedText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap:(){
        if(selectedText != null){
          selectedText!();
        }
      },
        child: Container(
            child: Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: SpookerSize.m10),
          alignment: Alignment.center,
          height: SpookerSize.m2,
          decoration: getDecorationByStatement(),
        ),
        Align(
            alignment: Alignment.topCenter,
            child: Container(
              color: SpookerColors.completeLight,
              child: Text(
                titleText.toUpperCase(),
                style: getFontByStatement(),
              ),
            ))
      ],
    )));
  }

  BoxDecoration getDecorationByStatement() {
    if (highlight) {
      return BoxDecoration(gradient: SpookerColors.rightGradient);
    } else {
      return BoxDecoration(color: SpookerColors.completeLight);
    }
  }

  TextStyle getFontByStatement() {
    if (highlight) {
      return SpookerFonts.s18BoldDarkBlue;
    } else {
      return SpookerFonts.s18MediumDarkBlue;
    }
  }
}
