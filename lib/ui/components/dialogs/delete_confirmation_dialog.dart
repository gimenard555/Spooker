import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../gen/assets.gen.dart';
import '../../utils/spooker_colors.dart';
import '../../utils/spooker_fonts.dart';
import '../../utils/spooker_sizes.dart';
import '../../utils/spooker_strings.dart';
import '../buttons/common_button_view.dart';
import '../spooker_borders.dart';

enum ConfirmationType { DELETE, CANCEL }

typedef DeleteConfirmationOptionSelected = void Function(ConfirmationType);

class DeleteConfirmationDialog extends HookConsumerWidget {
  DeleteConfirmationDialog(this._deletedObject, this._optionSelected);

  final String _deletedObject;
  final DeleteConfirmationOptionSelected _optionSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      backgroundColor: SpookerColors.transparent,
      insetPadding: EdgeInsets.all(SpookerSize.m20),
      elevation: SpookerSize.zero,
      shape: RoundedRectangleBorder(borderRadius: SpookerBorders.m30Border),
      child: Container(
        alignment: Alignment.center,
        child: Wrap(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: SpookerColors.completeLight,
                    borderRadius: SpookerBorders.m30Border,
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(
                              top: SpookerSize.m20, right: SpookerSize.m20),
                          child: Text(
                            SpookerStrings.spookerExit,
                            textAlign: TextAlign.center,
                            style: SpookerFonts.s16BoldDarkBlue,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: SpookerSize.m20),
                        alignment: Alignment.center,
                        child: Assets.images.mainLogo.image(
                            width: SpookerSize.m200, height: SpookerSize.m200),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: SpookerSize.m20,
                            vertical: SpookerSize.m10),
                        alignment: Alignment.center,
                        child: Text(
                          '${SpookerStrings.deleteMessage} $_deletedObject?',
                          textAlign: TextAlign.center,
                          style: SpookerFonts.s16BoldDarkBlue,
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: SpookerSize.m20),
                        alignment: Alignment.center,
                        child: Text(
                          SpookerStrings.deleteWarning,
                          textAlign: TextAlign.center,
                          style: SpookerFonts.s14BoldBlueCommon,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(
                                  horizontal: SpookerSize.m10,
                                  vertical: SpookerSize.m5),
                              child: CommonButtonView(
                                SpookerColors.noAvailableColor,
                                SpookerStrings.delete,
                                SpookerFonts.s16BoldLight,
                                () {
                                  _optionSelected(ConfirmationType.DELETE);
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(
                                  horizontal: SpookerSize.m10,
                                  vertical: SpookerSize.m5),
                              child: CommonButtonView(
                                SpookerColors.spookerBlue,
                                SpookerStrings.cancel,
                                SpookerFonts.s16BoldLight,
                                () {
                                  _optionSelected(ConfirmationType.CANCEL);
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
