import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';
import 'package:spooker/ui/utils/spooker_strings.dart';

import '../../../data/model/enums.dart';
import '../../../gen/assets.gen.dart';

typedef OnOptionSelected = void Function(Option option);

class OptionDialog extends HookConsumerWidget {
  OptionDialog(this.onOptionSelected);

  final OnOptionSelected onOptionSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
        backgroundColor: SpookerColors.transparent,
        elevation: SpookerSize.zero,
        child: Container(
            width: double.infinity,
            height: double.infinity,
            color: SpookerColors.transparent,
            child: Container(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          SpookerStrings.newSpooker,
                          textAlign: TextAlign.right,
                          style: SpookerFonts.s16MediumLight,
                        )),
                        SizedBox(width: SpookerSize.m10),
                        Assets.images.miniLogo.image(width: SpookerSize.m50, height: SpookerSize.m50)
                      ],
                    ),
                    SizedBox(width: SpookerSize.m20),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          SpookerStrings.newArtwork,
                          textAlign: TextAlign.right,
                          style: SpookerFonts.s16MediumLight,
                        )),
                        SizedBox(width: SpookerSize.m10),
                        Assets.images.artwork.image(width: SpookerSize.m50, height: SpookerSize.m50)
                      ],
                    ),
                    SizedBox(width: SpookerSize.m20),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          SpookerStrings.newReminder,
                          textAlign: TextAlign.right,
                          style: SpookerFonts.s16MediumLight,
                        )),
                        SizedBox(width: SpookerSize.m10),
                        Assets.images.reminder.image(width: SpookerSize.m50, height: SpookerSize.m50)
                      ],
                    ),
                  ],
                ))));
  }
}
