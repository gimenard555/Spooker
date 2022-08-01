import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../gen/assets.gen.dart';
import '../../utils/spooker_fonts.dart';
import '../../utils/spooker_strings.dart';

class EmptyView extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Column(
        children: [
          Assets.images.emptyLogo.image(),
          Text(
            SpookerStrings.emptySpooker,
            textAlign: TextAlign.center,
            style: SpookerFonts.s16BoldNoAvailable,
          )
        ],
      ),
    );
  }
}
