import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/components/main_screen_extension.dart';
import 'package:spooker/ui/screens/artwork/new_artwork_screen.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';

import '../../../data/model/artwork.dart';
import '../../components/buttons/common_button_view.dart';
import '../../components/dialogs/delete_confirmation_dialog.dart';
import '../../components/image/image.dart';
import '../../components/spooker_borders.dart';
import '../../components/top_bar_view.dart';
import '../../utils/spooker_colors.dart';
import '../../utils/spooker_strings.dart';
import 'artwork_view_model.dart';

// ignore: must_be_immutable
class ArtworkDetail extends HookConsumerWidget {
  ArtworkDetail(this._artwork);

  final Artwork _artwork;
  late ArtworkViewModel _viewModel;
  late double screenWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _viewModel = ref.watch(artworkViewModel);
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopBarView(SpookerStrings.artwork),
            Container(
              margin: EdgeInsets.only(
                left: SpookerSize.m20,
                right: SpookerSize.m20,
                top: SpookerSize.m20,
                bottom: SpookerSize.zero,
              ),
              child: Text(
                _artwork.name.toUpperCase(),
                textAlign: TextAlign.center,
                style: SpookerFonts.s20MediumDarkBlue,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: SpookerSize.m20,
                right: SpookerSize.m20,
                top: SpookerSize.zero,
                bottom: SpookerSize.m20,
              ),
              child: Text(
                'BY ${_artwork.username}',
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
            Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        top: SpookerSize.m20,
                        bottom: SpookerSize.m20,
                        left: SpookerSize.m20,
                        right: SpookerSize.m10),
                    child: CommonButtonView(
                      SpookerColors.noAvailableColor,
                      SpookerStrings.delete,
                      SpookerFonts.s16BoldLight,
                      () {
                        context.showDeleteWarning(SpookerStrings.artwork,
                            (type) {
                          switch (type) {
                            case ConfirmationType.DELETE:
                              _viewModel.deleteArtwork(_artwork.id);
                              Navigator.pop(context);
                              break;
                            case ConfirmationType.CANCEL:
                              Navigator.pop(context);
                              break;
                          }
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        top: SpookerSize.m20,
                        bottom: SpookerSize.m20,
                        left: SpookerSize.m10,
                        right: SpookerSize.m20),
                    child: CommonButtonView(
                      SpookerColors.spookerBlue,
                      SpookerStrings.edit,
                      SpookerFonts.s16BoldLight,
                      () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewArtworkScreen(
                                    artwork: _artwork,
                                    artworkId: _artwork.id,
                                  )),
                        );
                      },
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
