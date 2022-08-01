import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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

class NewEventScreen extends HookConsumerWidget {
  late EventViewModel _viewModel;
  late TextEditingController _titleController;
  late TextEditingController _dateFieldController;
  late TextEditingController _placeFieldController;

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
              TopBarView(SpookerStrings.newArtwork),
              Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: SpookerSize.m20, vertical: SpookerSize.m5),
                  alignment: Alignment.center,
                  child: TextFormView(
                    textController: _titleController,
                    textHint: SpookerStrings.eventTitle,
                    errorMessage: '',
                    isValidText: _viewModel.title.isNotEmpty,
                  )),
              Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: SpookerSize.m20, vertical: SpookerSize.m5),
                  alignment: Alignment.center,
                  child: TextFormView(
                    textController: _dateFieldController,
                    textHint: SpookerStrings.eventDate,
                    errorMessage: '',
                    isValidText: _viewModel.date.isNotEmpty,
                    onTouchText: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      context.showDateDialog((date, dateTime) {
                        _viewModel.date = date;
                        _dateFieldController.text = date;
                      });
                    },
                  )),
              Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: SpookerSize.m20, vertical: SpookerSize.m5),
                  alignment: Alignment.center,
                  child: TextFormView(
                    textController: _placeFieldController,
                    textHint: SpookerStrings.eventPlace,
                    errorMessage: '',
                    isValidText: _viewModel.place.isNotEmpty,
                  )),
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

    _placeFieldController =
        useTextEditingController.fromValue(TextEditingValue.empty);
    _placeFieldController.addListener(() {
      _viewModel.place = _placeFieldController.text;
    });
  }
}
