import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';

typedef WhenPress = void Function();

// ignore: must_be_immutable
class MainButtonView extends HookConsumerWidget {
  MainButtonView(
      {required this.buttonText,
      required this.isAvailable,
      required this.whenPress});

  final String buttonText;
  bool isAvailable = false;
  final WhenPress whenPress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: Padding(
            padding: EdgeInsets.all(5),
            child: ElevatedButton(
                onPressed: onPressedByAvailable,
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      buttonText,
                      style: getTextStyleByAvailable(),
                    )),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        getButtonStyleByAvailable()),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ))))),
      ),
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: getButtonBorderByAvailable(),
    );
  }

  BoxDecoration getButtonBorderByAvailable() {
    if (isAvailable) {
      return BoxDecoration(
        gradient: SpookerColors.rightGradient,
        border: Border.all(
          color: SpookerColors.lightGray,
        ),
        borderRadius: BorderRadius.circular(30),
      );
    } else {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      );
    }
  }

  TextStyle getTextStyleByAvailable() {
    if (isAvailable) {
      return SpookerFonts.buttonAvailable;
    } else {
      return SpookerFonts.buttonNoAvailable;
    }
  }

  Color getButtonStyleByAvailable() {
    if (isAvailable) {
      return SpookerColors.completeLight;
    } else {
      return SpookerColors.noAvailableColor;
    }
  }

  void onPressedByAvailable() {
    if (isAvailable) {
      whenPress();
    }
  }
}
