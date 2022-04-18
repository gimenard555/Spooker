import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';
import 'package:spooker/ui/utils/spooker_strings.dart';

import '../spooker_borders.dart';

class GoogleButtonView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(SpookerSize.m5),
        child: Container(
          child: Text(SpookerStrings.GoogleButtonText),
          decoration: BoxDecoration(
            color: SpookerColors.lightGray,
            border: Border.all(color: SpookerColors.darkBlue),
            borderRadius: SpookerBorders.m30Border,
          ),
        ),
      ),
      height: SpookerSize.m30,
    );
  }
}
