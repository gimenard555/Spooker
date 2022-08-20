import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:spooker/ui/components/spooker_borders.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';
import 'package:spooker/ui/utils/spooker_strings.dart';
import '../../../data/model/enums.dart';
import '../../utils/spooker_numbers.dart';
import '../buttons/common_button_view.dart';

typedef OnDateSelected = void Function(String date, DateTime dateTime);

class SpookerDateDialog extends HookConsumerWidget {
  SpookerDateDialog(this.onDateSelected, this.isBefore,
      {this.firstDateAge = 0, this.lastDateAge = 0});

  final OnDateSelected onDateSelected;
  final bool isBefore;
  final int firstDateAge;
  final int lastDateAge;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateSelected = ref.watch(dateSelectedProvider);
    return Dialog(
      backgroundColor: SpookerColors.transparent,
      insetPadding: EdgeInsets.all(SpookerSize.m20),
      shape: RoundedRectangleBorder(borderRadius: SpookerBorders.m30Border),
      child: Stack(
        children: [
          Container(
            height: SpookerSize.m600,
            width: double.infinity,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: SpookerColors.completeLight,
              borderRadius: SpookerBorders.m30Border,
            ),
            child: Column(children: [
              Row(
                children: [
                  Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                              horizontal: SpookerSize.m20,
                              vertical: SpookerSize.m20),
                          child: Text(
                            SpookerStrings.dateSelectionButtonText,
                            textAlign: TextAlign.center,
                            style: SpookerFonts.s16BoldDarkBlue,
                          ))),
                  Container(
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.symmetric(
                          horizontal: SpookerSize.m20,
                          vertical: SpookerSize.m20),
                      child: Text(
                        SpookerStrings.spookerExit,
                        textAlign: TextAlign.center,
                        style: SpookerFonts.s16BoldDarkBlue,
                      )),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: SpookerSize.m20, vertical: SpookerSize.m10),
                child: Text(
                  dateSelected.date,
                  textAlign: TextAlign.center,
                  style: SpookerFonts.s20BoldCommonBlue,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: SpookerSize.m10, vertical: SpookerSize.m5),
                child: Theme(
                  data: ThemeData(
                    colorScheme:
                        ColorScheme.light(primary: SpookerColors.darkBlue),
                    textTheme: TextTheme(
                      caption: SpookerFonts.s14RegularDark,
                      bodyText1: SpookerFonts.s14RegularDark,
                      subtitle2: SpookerFonts.s16RegularDarkBlue,
                    ),
                  ),
                  child: CalendarDatePicker(
                    initialDate: getCurrentDate(),
                    firstDate: getDate(firstDateAge),
                    lastDate: getDate(lastDateAge),
                    onDateChanged: (DateTime selectedDate) {
                      var textDate = DateFormat(SpookerStrings.dateFormat)
                          .format(selectedDate);
                      dateSelected.selectDate(textDate);
                      onDateSelected(textDate, selectedDate);
                    },
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(
                      right: SpookerSize.m20,
                      left: SpookerSize.m20,
                      top: SpookerSize.m5,
                      bottom: SpookerSize.m5),
                  child: CommonButtonView(
                      SpookerColors.blueCommonTextColor,
                      SpookerStrings.continueText,
                      SpookerFonts.s14BoldLight, () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    Navigator.pop(context);
                  })),
            ]),
          ),
        ],
      ),
    );
  }

  DateTime getDate(int years) {
    if (years.isEqual(SpookerNumbers.zero)) {
      return DateTime.now();
    }
    if (isBefore) {
      return DateTime.now()
          .subtract(Duration(days: years * SpookerNumbers.daysOnYear));
    } else {
      return DateTime.now()
          .add(Duration(days: years * SpookerNumbers.daysOnYear));
    }
  }

  DateTime getCurrentDate() {
    if (isBefore) {
      return getDate(lastDateAge);
    } else {
      return getDate(firstDateAge);
    }
  }
}

final dateSelectedProvider =
    ChangeNotifierProvider((ref) => DateSelectedState());

class DateSelectedState extends ChangeNotifier {
  String _date = '';

  String get date => _date;

  void selectDate(String date) {
    _date = date;
    notifyListeners();
  }
}
