import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/gen/assets.gen.dart';
import 'package:spooker/ui/utils/spooker_strings.dart';

import '../../utils/spooker_colors.dart';
import '../../utils/spooker_fonts.dart';
import '../../utils/spooker_sizes.dart';
import '../spooker_borders.dart';

enum ImageType { CAMERA, GALLERY }

typedef ImageOptionSelected = void Function(ImageType);

class ImageBottomSheet extends HookConsumerWidget {
  ImageBottomSheet(this._optionSelected);

  final ImageOptionSelected _optionSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: SpookerColors.lightGray),
        borderRadius: SpookerBorders.borderRadiusTop,
        color: SpookerColors.completeLight,
      ),
      child: Wrap(
        children: [
          Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(SpookerSize.m20),
                child: Text(
                  SpookerStrings.imageOptionTitle,
                  textAlign: TextAlign.center,
                  style: SpookerFonts.s16BoldDarkBlue,
                ),
              ),
              InkWell(
                onTap: () {
                  _optionSelected(ImageType.CAMERA);
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.all(SpookerSize.m20),
                  child: Row(
                    children: [
                      Assets.images.camera.image(),
                      SizedBox(
                        width: SpookerSize.m20,
                      ),
                      Text(
                        SpookerStrings.takePicture,
                        textAlign: TextAlign.left,
                        style: SpookerFonts.s16RegularDarkBlue,
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _optionSelected(ImageType.GALLERY);
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.all(SpookerSize.m20),
                  child: Row(
                    children: [
                      Assets.images.gallery.image(),
                      SizedBox(
                        width: SpookerSize.m20,
                      ),
                      Text(
                        SpookerStrings.selectFromYourGallery,
                        textAlign: TextAlign.left,
                        style: SpookerFonts.s16RegularDarkBlue,
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
