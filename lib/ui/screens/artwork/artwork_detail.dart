import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';

import '../../../data/model/artwork.dart';
import '../../components/image/image.dart';
import '../../components/spooker_borders.dart';
import '../../components/top_bar_view.dart';
import '../../utils/spooker_strings.dart';

class ArtworkDetail extends HookConsumerWidget {
  ArtworkDetail(this._artwork);

  final Artwork _artwork;

  late double screenWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopBarView(SpookerStrings.artwork),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: SpookerSize.m20, vertical: SpookerSize.m10),
              child: Text(
                _artwork.name,
                textAlign: TextAlign.center,
                style: SpookerFonts.s20MediumDarkBlue,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: SpookerSize.m20, vertical: SpookerSize.m10),
              child: Text(
                'BY ${_artwork.name}',
                textAlign: TextAlign.center,
                style: SpookerFonts.s20MediumCommonBlue,
              ),
            ),
            Container(
              margin: EdgeInsets.all(SpookerSize.m20),
              height: screenWidth,
              width: screenWidth,
              child: ClipRRect(
                borderRadius: SpookerBorders.m30Border,
                child: networkImage(_artwork.imagePath, fit: BoxFit.cover),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: SpookerSize.m20, vertical: SpookerSize.m10),
              child: Text(
                _artwork.description,
                textAlign: TextAlign.center,
                style: SpookerFonts.s14RegularDarkBlue,
              ),
            ),
            Row()
          ],
        ),
      ),
    );
  }
}
