import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:spooker/ui/components/main_screen_extension.dart';
import 'package:spooker/ui/screens/reminder/reminder_view_model.dart';

import '../../../data/model/reminder.dart';
import '../../components/Inputs/text_form_view.dart';
import '../../components/buttons/common_button_view.dart';
import '../../components/top_bar_view.dart';
import '../../utils/spooker_colors.dart';
import '../../utils/spooker_fonts.dart';
import '../../utils/spooker_sizes.dart';
import '../../utils/spooker_strings.dart';

// ignore: must_be_immutable
class NewReminderScreen extends HookConsumerWidget {
  NewReminderScreen({this.reminder, this.reminderId});

  late ReminderViewModel _viewModel;
  late TextEditingController _titleController;
  late TextEditingController _dateFieldController;
  late TextEditingController _hourFieldController;
  late TextEditingController _placeFieldController;

  final Reminder? reminder;
  final String? reminderId;

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
                  isValidText: _titleController.text.isNotEmpty ||
                      _viewModel.title.isNotEmpty,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: SpookerSize.m20, vertical: SpookerSize.m5),
                alignment: Alignment.center,
                child: TextFormView(
                  textController: _dateFieldController,
                  textHint: SpookerStrings.reminderDate,
                  errorMessage: '',
                  isValidText: _dateFieldController.text.isNotEmpty ||
                      _viewModel.date.isNotEmpty,
                  onTouchText: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    context.showDateDialog(
                      (date, dateTime) {
                        _viewModel.date = date;
                        _viewModel.selectedDate =
                            DateFormat("yyyy-MM-dd").format(dateTime);
                        _dateFieldController.text = date;
                      },
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: SpookerSize.m20, vertical: SpookerSize.m5),
                alignment: Alignment.center,
                child: TextFormView(
                  textController: _hourFieldController,
                  textHint: SpookerStrings.reminderHour,
                  errorMessage: '',
                  isValidText: _hourFieldController.text.isNotEmpty ||
                      _viewModel.hour.isNotEmpty,
                  onTouchText: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    _selectTime(context);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: SpookerSize.m20, vertical: SpookerSize.m5),
                alignment: Alignment.center,
                child: TextFormView(
                  textController: _placeFieldController,
                  textHint: SpookerStrings.reminderPlace,
                  errorMessage: '',
                  isValidText: _placeFieldController.text.isNotEmpty ||
                      _viewModel.place.isNotEmpty,
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                    horizontal: SpookerSize.m20, vertical: SpookerSize.m5),
                child: CommonButtonView(
                  SpookerColors.blueCommonTextColor,
                  _getButtonTextByData(),
                  SpookerFonts.s14BoldLight,
                  () {
                    _chargeViewModelData();
                    context.showLoading();
                    _editOrCreateByData(context);
                  },
                  isAvailable:
                      _textControllers() || _viewModel.isDataCompleted(),
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

  void _chargeViewModelData() {
    if (reminder != null && reminderId != null) {
      _viewModel.title = _titleController.text;
      _viewModel.date = _dateFieldController.text;
      _viewModel.hour = _hourFieldController.text;
      _viewModel.place = _placeFieldController.text;
    }
  }

  bool _textControllers() {
    return _titleController.text.isNotEmpty &&
        _dateFieldController.text.isNotEmpty &&
        _hourFieldController.text.isNotEmpty &&
        _placeFieldController.text.isNotEmpty;
  }

  void _initTextControllers() {
    if (reminder != null && reminderId != null) {
      _titleController = useTextEditingController(text: reminder!.description);
      _dateFieldController = useTextEditingController(text: reminder!.date);
      _hourFieldController = useTextEditingController(text: reminder!.hour);
      _placeFieldController = useTextEditingController(text: reminder!.place);
    } else if (reminder == null && reminderId == null) {
      _titleController =
          useTextEditingController.fromValue(TextEditingValue.empty);
      _dateFieldController =
          useTextEditingController.fromValue(TextEditingValue.empty);
      _hourFieldController =
          useTextEditingController.fromValue(TextEditingValue.empty);
      _placeFieldController =
          useTextEditingController.fromValue(TextEditingValue.empty);
    }
    _titleController.addListener(() {
      _viewModel.title = _titleController.text;
    });
    _placeFieldController.addListener(() {
      _viewModel.place = _placeFieldController.text;
    });
  }

  String _getButtonTextByData() {
    if (reminder != null && reminderId != null) {
      return SpookerStrings.editText;
    } else {
      return SpookerStrings.continueText;
    }
  }

  void _editOrCreateByData(BuildContext context) {
    if (reminder != null && reminderId != null) {
      _viewModel
          .editReminder(reminderId!)
          .whenComplete(() => {_manageState(context)});
    } else {
      _viewModel.createNewEvent().whenComplete(() => {_manageState(context)});
    }
  }
}
