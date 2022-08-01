import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:spooker/data/model/enums.dart';
import 'package:spooker/ui/components/main_screen_extension.dart';
import 'package:spooker/ui/screens/reminder/reminder_view_model.dart';

import '../../components/Inputs/text_form_view.dart';
import '../../components/buttons/common_button_view.dart';
import '../../components/top_bar_view.dart';
import '../../utils/spooker_colors.dart';
import '../../utils/spooker_fonts.dart';
import '../../utils/spooker_sizes.dart';
import '../../utils/spooker_strings.dart';

class NewReminderScreen extends HookConsumerWidget {
  late ReminderViewModel _viewModel;
  late TextEditingController _titleController;
  late TextEditingController _dateFieldController;
  late TextEditingController _hourFieldController;
  late TextEditingController _placeFieldController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _viewModel = ref.watch(reminderViewModelProvider);
    _initTextControllers();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              TopBarView(SpookerStrings.newReminder),
              Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: SpookerSize.m20, vertical: SpookerSize.m5),
                  alignment: Alignment.center,
                  child: TextFormView(
                    textController: _titleController,
                    textHint: SpookerStrings.reminderTitle,
                    errorMessage: '',
                    isValidText: _viewModel.title.isNotEmpty,
                  )),
              Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: SpookerSize.m20, vertical: SpookerSize.m5),
                  alignment: Alignment.center,
                  child: TextFormView(
                      textController: _dateFieldController,
                      textHint: SpookerStrings.reminderDate,
                      errorMessage: '',
                      isValidText: _viewModel.date.isNotEmpty,
                      onTouchText: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        context.showDateDialog((date, dateTime) {
                          _viewModel.date = date;
                          _viewModel.selectedDate =
                              DateFormat("yyyy-MM-dd")
                                  .format(dateTime);
                          _dateFieldController.text = date;
                        });
                      })),
              Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: SpookerSize.m20, vertical: SpookerSize.m5),
                  alignment: Alignment.center,
                  child: TextFormView(
                      textController: _hourFieldController,
                      textHint: SpookerStrings.reminderHour,
                      errorMessage: '',
                      isValidText: _viewModel.hour.isNotEmpty,
                      onTouchText: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        _selectTime(context);
                      })),
              Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: SpookerSize.m20, vertical: SpookerSize.m5),
                  alignment: Alignment.center,
                  child: TextFormView(
                    textController: _placeFieldController,
                    textHint: SpookerStrings.reminderPlace,
                    errorMessage: '',
                    isValidText: _viewModel.place.isNotEmpty,
                  )),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                    horizontal: SpookerSize.m20, vertical: SpookerSize.m5),
                child: CommonButtonView(
                  SpookerColors.blueCommonTextColor,
                  SpookerStrings.continueText,
                  SpookerFonts.s14BoldLight,
                  () {
                    context.showLoading();
                    _viewModel
                        .createNewEvent()
                        .whenComplete(() => {_manageState(context)});
                  },
                  isAvailable: _viewModel.isDataCompleted(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      MaterialLocalizations localizations = MaterialLocalizations.of(context);
      String formattedTime = localizations.formatTimeOfDay(timeOfDay,
          alwaysUse24HourFormat: false);
      _hourFieldController.text = formattedTime;
      _viewModel.hour = formattedTime;
    }
  }

  void _manageState(BuildContext context) {
    Navigator.pop(context);
    if (_viewModel.isSaved) {
      Navigator.pop(context);
    } else {
      context.showErrorDialog(SpookerErrorStrings.dialogWrong);
    }
  }

  void _initTextControllers() {
    _titleController =
        useTextEditingController.fromValue(TextEditingValue.empty);
    _titleController.addListener(() {
      _viewModel.title = _titleController.text;
    });

    _dateFieldController =
        useTextEditingController.fromValue(TextEditingValue.empty);

    _hourFieldController =
        useTextEditingController.fromValue(TextEditingValue.empty);

    _placeFieldController =
        useTextEditingController.fromValue(TextEditingValue.empty);
    _placeFieldController.addListener(() {
      _viewModel.place = _placeFieldController.text;
    });
  }
}
