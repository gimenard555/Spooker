import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';

class MainButtonView extends HookConsumerWidget {
  MainButtonView({required this.buttonText});

  final String buttonText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: Padding(
            padding: EdgeInsets.all(5),
            child: ElevatedButton(
              onPressed: () {},
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    buttonText,
                    style: SpookerFonts.textFormNormal,
                  )),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      SpookerColors.completeLight),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side:
                              BorderSide(color: SpookerColors.completeLight)))),
            )),
      ),
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: okBorderButton,
    );
  }

  final okBorderButton = BoxDecoration(
    gradient: SpookerColors.rightGradient,
    border: Border.all(
      color: SpookerColors.lightGray,
    ),
    borderRadius: BorderRadius.circular(30),
  );

  final innerButton = BoxDecoration(
    color: SpookerColors.completeLight,
    border: Border.all(color: SpookerColors.completeLight),
    borderRadius: BorderRadius.circular(60),
  );
}