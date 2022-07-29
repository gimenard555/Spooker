import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';
import '../../utils/spooker_colors.dart';
import '../../utils/spooker_fonts.dart';
import '../spooker_borders.dart';

class TagText extends HookConsumerWidget {
  const TagText({Key? key, required this.tagText}) : super(key: key);

  final String tagText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
          width: SpookerSize.m120,
          height: SpookerSize.m30,
          decoration: BoxDecoration(
              color: SpookerColors.spookerBlue,
              borderRadius: SpookerBorders.borderTag),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "@$tagText",
              style: SpookerFonts.s12MediumLightGray,
            ),
          )),
    );
  }
}
