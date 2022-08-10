import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/data/model/event.dart';
import 'package:spooker/ui/components/main_screen_extension.dart';
import 'package:spooker/ui/screens/event/event_view_model.dart';

import '../../components/buttons/common_button_view.dart';
import '../../components/dialogs/delete_confirmation_dialog.dart';
import '../../components/outputs/custom_tag_text.dart';
import '../../components/spooker_borders.dart';
import '../../utils/spooker_colors.dart';
import '../../utils/spooker_fonts.dart';
import '../../utils/spooker_sizes.dart';
import '../../utils/spooker_strings.dart';
import 'new_event_screen.dart';

// ignore: must_be_immutable
class EventDetailDialog extends HookConsumerWidget {
  EventDetailDialog(this._event);

  final Event _event;
  late EventViewModel _viewModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _viewModel = ref.watch(eventViewModel);
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
                  margin: EdgeInsets.only(top: SpookerSize.m20),
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
                          margin: EdgeInsets.symmetric(
                              horizontal: SpookerSize.m20,
                              vertical: SpookerSize.m20),
                          child: Text(
                            SpookerStrings.spookerExit,
                            textAlign: TextAlign.center,
                            style: SpookerFonts.s16BoldDarkBlue,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(
                          horizontal: SpookerSize.m20,
                        ),
                        child: Text(
                          _event.name,
                          textAlign: TextAlign.center,
                          style: SpookerFonts.s20BoldDarkBlue,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(
                          horizontal: SpookerSize.m20,
                        ),
                        child: Text(
                          'BY @${_event.username}',
                          textAlign: TextAlign.center,
                          style: SpookerFonts.s16BoldBlueCommon,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            top: SpookerSize.m20,
                            left: SpookerSize.m20,
                            right: SpookerSize.m20),
                        child: Text(
                          _event.date,
                          textAlign: TextAlign.center,
                          style: SpookerFonts.s16RegularDarkBlue,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin:
                            EdgeInsets.symmetric(horizontal: SpookerSize.m20),
                        child: Text(
                          _event.hour,
                          textAlign: TextAlign.center,
                          style: SpookerFonts.s16RegularDarkBlue,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin:
                            EdgeInsets.symmetric(horizontal: SpookerSize.m20),
                        child: Text(
                          _event.place,
                          textAlign: TextAlign.center,
                          style: SpookerFonts.s16RegularDarkBlue,
                        ),
                      ),
                      getOptions(context),
                    ],
                  ),
                ),
                Container(
                    alignment: Alignment.topCenter,
                    child: TagText('#${_event.tag}')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getOptions(BuildContext context) {
    if (_event.eventId.isNotEmpty) {
      return Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(
                  horizontal: SpookerSize.m10, vertical: SpookerSize.m5),
              child: CommonButtonView(
                SpookerColors.noAvailableColor,
                SpookerStrings.delete,
                SpookerFonts.s16BoldLight,
                () {
                  context.showDeleteWarning(SpookerStrings.event, (type) {
                    switch (type) {
                      case ConfirmationType.DELETE:
                        _viewModel.deleteEvent(_event.eventId);
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
              margin: EdgeInsets.symmetric(
                  horizontal: SpookerSize.m10, vertical: SpookerSize.m5),
              child: CommonButtonView(
                SpookerColors.spookerBlue,
                SpookerStrings.edit,
                SpookerFonts.s16BoldLight,
                () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewEventScreen(
                              event: _event,
                              eventId: _event.eventId,
                            )),
                  );
                },
              ),
            ),
          ),
        ],
      );
    } else {
      return SizedBox(
        height: SpookerSize.m60,
      );
    }
  }
}
