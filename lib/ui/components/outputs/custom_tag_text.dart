import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';
import '../../utils/spooker_colors.dart';
import '../../utils/spooker_fonts.dart';
import '../spooker_borders.dart';

class TagText extends HookConsumerWidget {
  const TagText(this._tagText);

  final String _tagText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(SpookerSize.m2),
      width: SpookerSize.m120,
      height: SpookerSize.m30,
      decoration: BoxDecoration(
          color: SpookerColors.spookerBlue,
          borderRadius: SpookerBorders.borderTag),
      child: Text(
        "@$_tagText",
        style: SpookerFonts.s12MediumLightGray,
        textAlign: TextAlign.center,
      ),
    );
  }
}
