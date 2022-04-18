import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';

class CustomTextTitle extends HookConsumerWidget {
  const CustomTextTitle({Key? key, required this.titleText}) : super(key: key);

  final String titleText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: SpookerSize.m10,
            ),
            Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: double.infinity,
                          height: SpookerSize.m2,
                          decoration: BoxDecoration(
                              gradient: SpookerColors.rightGradient),
                        )),
                  ],
                ),
                Align(
                    alignment: Alignment.center,
                    child: Container(
                        color: SpookerColors.completeLight,
                        child: Text(
                          titleText.toUpperCase(),
                          style: SpookerFonts.dashboardTitleText,
                        ))),
              ],
            ),
          ],
        ));
  }
}
