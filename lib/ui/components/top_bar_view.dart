import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/components/screen/main_curve_background.dart';

import '../../gen/assets.gen.dart';
import '../utils/spooker_fonts.dart';
import '../utils/spooker_sizes.dart';

class TopBarView extends HookConsumerWidget {
  TopBarView(this.screenTitle);

  final String screenTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Container(
          height: screenHeight * 0.08,
          width: double.infinity,
          child: CustomPaint(
            painter: MainCurve(),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
              padding: EdgeInsets.all(SpookerSize.m10),
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.all(SpookerSize.m10),
              child: Assets.images.backButton.image()),
        ),
        Container(
          padding: EdgeInsets.all(SpookerSize.m20),
          alignment: Alignment.center,
          child: Text(
            screenTitle,
            textAlign: TextAlign.center,
            style: SpookerFonts.s20BoldLight,
          ),
        ),
      ],
    );
  }
}
