import 'package:flutter/material.dart';
import 'package:spooker/ui/components/dialogs/spooker_loading_dialog.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'dialogs/floating_options_dialog.dart';
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

  void showOptions(OnOptionSelected onOptionSelected) {
    showDialog(
        context: this,
        barrierDismissible: true,
        barrierColor: SpookerColors.optionsBackground,
        builder: (_) {
          return OptionDialog(onOptionSelected);
        });
  }
}
