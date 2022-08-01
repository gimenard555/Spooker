import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/data/model/reminder.dart';
import 'package:spooker/ui/components/main_screen_extension.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';

import '../../utils/spooker_fonts.dart';

class ReminderItem extends HookConsumerWidget {
  ReminderItem(this._reminder);

  final Reminder _reminder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isChecked = ref.watch(isCheckedProvider);
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: SpookerSize.m10, vertical: SpookerSize.m5),
      child: Row(
        children: [
          Checkbox(
            value: isChecked.checkState,
            onChanged: (value) {
              isChecked.checkReminder(value!);
            },
            shape: CircleBorder(),
            checkColor: SpookerColors.completeLight,
            fillColor:
                MaterialStateProperty.all(SpookerColors.blueCommonTextColor),
          ),
          Text(
            _reminder.hour,
            textAlign: TextAlign.center,
            style: SpookerFonts.s14BoldBlueCommon,
          ),
          SizedBox(width: SpookerSize.m20),
          Expanded(
            child: InkWell(
              onTap: () {
                context.showReminderDetail(_reminder);
              },
              child: Text(
                _reminder.description,
                textAlign: TextAlign.justify,
                style: SpookerFonts.s14RegularDark,
              ),
            ),
          )
        ],
      ),
    );
  }
}

final isCheckedProvider = ChangeNotifierProvider((ref) => CheckSelectedState());

class CheckSelectedState extends ChangeNotifier {
  bool _checkState = false;

  bool get checkState => _checkState;

  void checkReminder(bool check) {
    _checkState = check;
    notifyListeners();
  }
}
