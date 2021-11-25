import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';
import 'package:spooker/ui/utils/spooker_strings.dart';

class GoogleButtonView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          child: Text(SpookerStrings.GoogleButtonText),
          decoration: BoxDecoration(
            color: SpookerColors.lightGray,
            border: Border.all(color: SpookerColors.darkBlue),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      height: SpookerSize.buttonHeight,
    );
  }
}
