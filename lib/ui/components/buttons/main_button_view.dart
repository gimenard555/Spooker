import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/components/spooker_borders.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';

typedef WhenPress = void Function();

// ignore: must_be_immutable
class MainButtonView extends HookConsumerWidget {
  MainButtonView(
      {required this.buttonText,
      required this.isAvailable,
      required this.whenPress,
      this.isNormal = false,
      this.buttonImage});

  final String buttonText;
  bool isAvailable = false;
  final WhenPress whenPress;
  bool isNormal = false;
  Image? buttonImage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(returnPadding()),
      child: ElevatedButton(
        onPressed: () {
          if (isAvailable) {
            whenPress();
          }
        },
        child: getIconButton(),
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(getButtonStyleByAvailable()),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: SpookerBorders.m30Border,
            ))),
      ),
      height: SpookerSize.m60,
      width: MediaQuery.of(context).size.width,
      decoration: getButtonBorderByAvailable(),
    );
  }

  Widget getIconButton() {
    if (buttonImage != null) {
      return Expanded(
          child: Container(
              margin: EdgeInsets.symmetric(vertical: SpookerSize.m10),
              child: Stack(
                children: [
                  buttonImage!,
                  Expanded(
                      child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      buttonText,
                      style: getTextStyleByAvailable(),
                    ),
                  ))
                ],
              )));
    } else {
      return Align(
          alignment: Alignment.center,
          child: Text(
            buttonText,
            style: getTextStyleByAvailable(),
          ));
    }
  }

  BoxDecoration getButtonBorderByAvailable() {
    if (isNormal) {
      return BoxDecoration(
        border: Border.all(
          width: SpookerSize.m3,
          color: SpookerColors.darkBlue,
        ),
        borderRadius: SpookerBorders.m30Border,
      );
    } else {
      if (isAvailable) {
        return BoxDecoration(
          gradient: SpookerColors.rightGradient,
          border: Border.all(
            color: SpookerColors.lightGray,
          ),
          borderRadius: SpookerBorders.m30Border,
        );
      } else {
        return BoxDecoration(
          borderRadius: SpookerBorders.m30Border,
        );
      }
    }
  }

  TextStyle getTextStyleByAvailable() {
    if (isNormal) {
      return SpookerFonts.blueButtonText;
    } else {
      if (isAvailable) {
        return SpookerFonts.buttonAvailable;
      } else {
        return SpookerFonts.buttonNoAvailable;
      }
    }
  }

  Color getButtonStyleByAvailable() {
    if (isAvailable) {
      return SpookerColors.completeLight;
    } else {
      return SpookerColors.noAvailableColor;
    }
  }

  double returnPadding() {
    if (isNormal) {
      return 0;
    } else {
      return 5;
    }
  }
}
