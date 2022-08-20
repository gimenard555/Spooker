import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:spooker/data/model/event.dart';
import 'package:spooker/ui/components/main_screen_extension.dart';
import 'package:spooker/ui/utils/spooker_strings.dart';

import '../../../data/model/enums.dart';
import '../../components/Inputs/text_form_view.dart';
import '../../components/buttons/common_button_view.dart';
import '../../components/pickers/spinner_view.dart';
import '../../components/top_bar_view.dart';
import '../../utils/spooker_colors.dart';
import '../../utils/spooker_fonts.dart';
import '../../utils/spooker_sizes.dart';
import '../event/event_view_model.dart';

// ignore: must_be_immutable
class NewEventScreen extends HookConsumerWidget {
  NewEventScreen({this.event, this.eventId});

  late EventViewModel _viewModel;
  late TextEditingController _titleController;
  late TextEditingController _dateFieldController;
  late TextEditingController _placeFieldController;
  late TextEditingController _hourFieldController;

  final Event? event;
  final String? eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _viewModel = ref.watch(eventViewModel);
    _initTextControllers();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              TopBarView(SpookerStrings.newEvent),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: SpookerSize.m20, vertical: SpookerSize.m5),
                alignment: Alignment.center,
                child: TextFormView(
                  textController: _titleController,
                  textHint: SpookerStrings.eventTitle,
                  errorMessage: '',
                  isValidText: _titleController.text.isNotEmpty ||
                      _viewModel.title.isNotEmpty,
                  isCapitalize: true,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: SpookerSize.m20, vertical: SpookerSize.m5),
                alignment: Alignment.center,
                child: TextFormView(
                  textController: _dateFieldController,
                  textHint: SpookerStrings.eventDate,
                  errorMessage: '',
                  isValidText: _dateFieldController.text.isNotEmpty ||
                      _viewModel.date.isNotEmpty,
                  onTouchText: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    context.showDateDialog((date, dateTime) {
                      _viewModel.date = date;
                      _viewModel.selectedDate =
                          DateFormat(SpookerStrings.dateTimeFormat)
                              .format(dateTime);
                      _dateFieldController.text = date;
                    }, firstDateAge: 0, lastDateAge: 1);
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
                  textHint: SpookerStrings.eventPlace,
                  errorMessage: '',
                  isValidText: _placeFieldController.text.isNotEmpty ||
                      _viewModel.place.isNotEmpty,
                  isCapitalize: true,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: SpookerSize.m20, vertical: SpookerSize.m5),
                alignment: Alignment.center,
                child: SpinnerView(
                    SpookerStrings.tagType,
                    Tags.values.map<String>((text) {
                      return text.name;
                    }).toList(), (value) {
                  _viewModel.tag = value;
                }),
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

  void _manageState(BuildContext context) {
    Navigator.pop(context);
    if (_viewModel.isSaved) {
      Navigator.pop(context);
    } else {
      context.showErrorDialog(SpookerErrorStrings.dialogWrong);
    }
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
      builder: (context, child) {
        return Theme(
            data: ThemeData(
              timePickerTheme: TimePickerThemeData(
                  dialBackgroundColor: SpookerColors.lightSpookerBlue,
                  hourMinuteColor: SpookerColors.lightSpookerBlue,
                  dayPeriodTextStyle: SpookerFonts.s14BoldBlueCommon),
              textTheme: TextTheme(
                overline: SpookerFonts.s14BoldBlueCommon,
                headline2: SpookerFonts.s24BoldBlueCommon,
              ),
              colorScheme:
                  ColorScheme.light(primary: SpookerColors.blueCommonTextColor),
              textButtonTheme: TextButtonThemeData(
                  style: ButtonStyle(
                      textStyle: MaterialStateProperty.all<TextStyle>(
                          SpookerFonts.s14BoldBlueCommon))),
            ),
            child: child!);
      },
    );
    if (timeOfDay != null) {
      MaterialLocalizations localizations = MaterialLocalizations.of(context);
      String formattedTime = localizations.formatTimeOfDay(timeOfDay,
          alwaysUse24HourFormat: false);
      _hourFieldController.text = formattedTime;
      _viewModel.hour = formattedTime;
    }
  }

  void _initTextControllers() {
    if (event != null && eventId != null) {
      _titleController = useTextEditingController(text: event!.name);
      _dateFieldController = useTextEditingController(text: event!.date);
      _hourFieldController = useTextEditingController(text: event!.hour);
      _placeFieldController = useTextEditingController(text: event!.place);
    } else if (event == null && event == null) {
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

  bool _textControllers() {
    return _titleController.text.isNotEmpty &&
        _dateFieldController.text.isNotEmpty &&
        _hourFieldController.text.isNotEmpty &&
        _placeFieldController.text.isNotEmpty;
  }

  String _getButtonTextByData() {
    if (event != null && eventId != null) {
      return SpookerStrings.editText;
    } else {
      return SpookerStrings.continueText;
    }
  }

  void _chargeViewModelData() {
    if (eventId != null && event != null) {
      _viewModel.title = _titleController.text;
      _viewModel.date = _dateFieldController.text;
      _viewModel.hour = _hourFieldController.text;
      _viewModel.place = _placeFieldController.text;
      if (_viewModel.tag.isEmpty) {
        _viewModel.tag = event!.tag;
      }
    }
  }

  void _editOrCreateByData(BuildContext context) {
    if (event != null && eventId != null) {
      _viewModel
          .editEvent(eventId!)
          .whenComplete(() => {_manageState(context)});
    } else {
      _viewModel.createNewEvent().whenComplete(() => {_manageState(context)});
    }
  }
}
