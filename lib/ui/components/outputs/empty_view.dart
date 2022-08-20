import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';

import '../../../gen/assets.gen.dart';
import '../../utils/spooker_fonts.dart';
import '../../utils/spooker_strings.dart';

class EmptyView extends HookConsumerWidget {
  EmptyView(this._emptyLabel);

  final String _emptyLabel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.center,
      child: Expanded(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(SpookerSize.m20),
              child: Assets.images.emptyLogo.image(),
            ),
            Container(
              margin: EdgeInsets.all(SpookerSize.m20),
              child: Text(
                '${SpookerStrings.emptyView} $_emptyLabel ${SpookerStrings.rightNow}',
                textAlign: TextAlign.center,
                style: SpookerFonts.s16BoldNoAvailable,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
