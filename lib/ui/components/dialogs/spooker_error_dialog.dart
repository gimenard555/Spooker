import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/utils/spooker_strings.dart';
import '../../../gen/assets.gen.dart';
import '../../utils/spooker_colors.dart';
import '../../utils/spooker_fonts.dart';
import '../../utils/spooker_sizes.dart';
import '../buttons/common_button_view.dart';
import '../spooker_borders.dart';

class ErrorDialog extends HookConsumerWidget {
  ErrorDialog(this.errorMessage);

  final String errorMessage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      backgroundColor: SpookerColors.transparent,
      insetPadding: EdgeInsets.all(SpookerSize.m20),
      shape: RoundedRectangleBorder(borderRadius: SpookerBorders.m30Border),
      child: Stack(
        children: [
          Container(
            height: SpookerSize.m400,
            width: double.infinity,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: SpookerColors.completeLight,
              borderRadius: SpookerBorders.m30Border,
            ),
            child: Column(children: [
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: SpookerSize.m20, vertical: SpookerSize.m20),
                child: Assets.images.errorLogo.image(),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: SpookerSize.m20, vertical: SpookerSize.m10),
                child: Text(
                  SpookerErrorStrings.error,
                  textAlign: TextAlign.center,
                  style: SpookerFonts.dialogTitleError,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: SpookerSize.m20, vertical: SpookerSize.m10),
                child: Text(
                  errorMessage,
                  textAlign: TextAlign.center,
                  style: SpookerFonts.s14RegularRed,
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: SpookerSize.m20, vertical: SpookerSize.m10),
                  child: CommonButtonView(
                      SpookerColors.blueCommonTextColor,
                      SpookerStrings.continueText,
                      SpookerFonts.s14BoldLight, () {
                    Navigator.pop(context);
                  })),
            ]),
          ),
        ],
      ),
    );
  }
}
