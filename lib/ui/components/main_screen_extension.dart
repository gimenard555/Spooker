import 'package:flutter/material.dart';
import 'package:spooker/data/model/event.dart';
import 'package:spooker/data/model/reminder.dart';
import 'package:spooker/ui/components/spooker_borders.dart';
import 'package:spooker/ui/screens/reminder/reminder_detail_dialog.dart';
import 'package:spooker/ui/components/dialogs/spooker_loading_dialog.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import '../../data/model/enums.dart';
import '../screens/event/event_detail_dialog.dart';
import 'dialogs/delete_confirmation_dialog.dart';
import 'dialogs/floating_options_dialog.dart';
import 'dialogs/image_bottom_sheet.dart';
import 'dialogs/spooker_date_dialog.dart';
import 'dialogs/spooker_error_dialog.dart';

extension MainScreen on BuildContext {
  void showErrorDialog(String errorMessage) {
    showDialog(
        context: this,
        builder: (_) {
          return ErrorDialog(errorMessage);
        },
        barrierDismissible: false);
  }

  void showLoading() {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (_) {
        return LoadingDialog();
      },
    );
  }

  void showDateDialog(OnDateSelected dateSelected) {
    showDialog(
        context: this,
        barrierDismissible: false,
        builder: (_) {
          return SpookerDateDialog(dateSelected);
        });
  }

  void showOptions() {
    showDialog(
        context: this,
        barrierDismissible: true,
        barrierColor: SpookerColors.optionsBackground,
        builder: (_) {
          return OptionDialog();
        });
  }

  void showReminderDetail(Reminder reminder) {
    showDialog(
        context: this,
        barrierDismissible: false,
        builder: (_) {
          return ReminderDetailDialog(reminder);
        });
  }

  void showDeleteWarning(
      String deletedObject, DeleteConfirmationOptionSelected option) {
    showDialog(
        context: this,
        barrierDismissible: false,
        builder: (_) {
          return DeleteConfirmationDialog(deletedObject, option);
        });
  }

  void showPhotoOptions(ImageOptionSelected optionSelected) {
    showModalBottomSheet(
        context: this,
        shape: RoundedRectangleBorder(borderRadius: SpookerBorders.m30Border),
        backgroundColor: SpookerColors.transparent,
        barrierColor: SpookerColors.optionsBackground,
        builder: (_) {
          return ImageBottomSheet(optionSelected);
        });
  }

  void showEventDetail(Event event) {
    showDialog(
        context: this,
        barrierDismissible: false,
        builder: (_) {
          return EventDetailDialog(event);
        });
  }
}
