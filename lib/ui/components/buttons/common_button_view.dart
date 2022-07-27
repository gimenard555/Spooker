import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';
import '../../utils/spooker_colors.dart';
import '../../utils/spooker_sizes.dart';
import '../spooker_borders.dart';

typedef CommonButtonPressed = void Function();

// ignore: must_be_immutable
class CommonButtonView extends HookConsumerWidget {
  CommonButtonView(
      this.backgroundColor, this.buttonText, this.textStyle, this.pressed,
      {this.isAvailable = true});

  final Color backgroundColor;
  final String buttonText;
  final TextStyle textStyle;
  final CommonButtonPressed pressed;
  bool isAvailable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: SpookerSize.m60,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: SpookerSize.m20, horizontal: 0),
      child: ElevatedButton(
        onPressed: () {
          pressed();
        },
        child: Text(
          buttonText,
          style: getTextFontByAvailable(),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(getBackgroundByAvailable()),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: SpookerBorders.m30Border,
            ))),
      ),
    );
  }

  TextStyle getTextFontByAvailable() {
    if (isAvailable) {
      return textStyle;
    } else {
      return SpookerFonts.s14BoldLight;
    }
  }

  Color getBackgroundByAvailable() {
    if (isAvailable) {
      return backgroundColor;
    } else {
      return SpookerColors.noAvailableColor;
    }
  }
}
