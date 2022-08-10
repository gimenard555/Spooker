import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/components/buttons/common_button_view.dart';
import 'package:spooker/ui/components/main_screen_extension.dart';
import 'package:spooker/ui/screens/reminder/reminder_view_model.dart';

import '../../../data/model/reminder.dart';
import '../../components/dialogs/delete_confirmation_dialog.dart';
import '../../utils/spooker_colors.dart';
import '../../utils/spooker_fonts.dart';
import '../../utils/spooker_sizes.dart';
import '../../utils/spooker_strings.dart';
import '../../components/outputs/custom_tag_text.dart';
import '../../components/spooker_borders.dart';
import 'new_reminder_screen.dart';

class ReminderDetailDialog extends HookConsumerWidget {
  ReminderDetailDialog(this._reminder);

  final Reminder _reminder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var viewModel = ref.watch(reminderViewModelProvider);
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
                          _reminder.description,
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
                          'BY @${_reminder.userId}',
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
                          _reminder.date,
                          textAlign: TextAlign.center,
                          style: SpookerFonts.s16RegularDarkBlue,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin:
                            EdgeInsets.symmetric(horizontal: SpookerSize.m20),
                        child: Text(
                          _reminder.hour,
                          textAlign: TextAlign.center,
                          style: SpookerFonts.s16RegularDarkBlue,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin:
                            EdgeInsets.symmetric(horizontal: SpookerSize.m20),
                        child: Text(
                          _reminder.place,
                          textAlign: TextAlign.center,
                          style: SpookerFonts.s16RegularDarkBlue,
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
                                  context.showDeleteWarning(
                                      SpookerStrings.reminder, (type) {
                                    switch (type) {
                                      case ConfirmationType.DELETE:
                                        viewModel.deleteReminder(_reminder.id);
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
                                  horizontal: SpookerSize.m10,
                                  vertical: SpookerSize.m5),
                              child: CommonButtonView(
                                SpookerColors.spookerBlue,
                                SpookerStrings.edit,
                                SpookerFonts.s16BoldLight,
                                () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NewReminderScreen(
                                              reminder: _reminder,
                                              reminderId: _reminder.id,
                                            )),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                    alignment: Alignment.topCenter,
                    child: TagText(_reminder.description)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
