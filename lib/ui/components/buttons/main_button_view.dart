import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';

class MainButtonView extends HookWidget {
  MainButtonView({required this.buttonText});

  String buttonText;

  final okBorderButton = BoxDecoration(
    gradient: SpookerColors.rightGradient,
    border: Border.all(
      color: SpookerColors.lightGray,
    ),
    borderRadius: BorderRadius.circular(30),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          child: Text(buttonText),
          decoration: BoxDecoration(
            color: SpookerColors.completeLight,
            border: Border.all(color: SpookerColors.completeLight),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      height: SpookerSize.buttonHeight,
      decoration: okBorderButton,
    );
  }
}
