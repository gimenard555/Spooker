import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/components/main_screen_extension.dart';

import '../../components/Inputs/text_form_view.dart';
import '../../components/buttons/main_button_view.dart';
import '../../components/screen/authentication_background_screen.dart';
import '../../utils/spooker_fonts.dart';
import '../../utils/spooker_sizes.dart';
import '../../utils/spooker_strings.dart';
import 'login_view_model.dart';

// ignore: must_be_immutable
class RecoverPasswordScreen extends HookConsumerWidget {
  late LoginViewModel _viewModel;
  late TextEditingController _emailFieldController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _viewModel = ref.watch(loginViewModelProvider);
    _initControllers();
    return Scaffold(
      body: AuthenticationBackground([
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(SpookerSize.m20),
          child: Text(
            SpookerStrings.forgotPasswordText,
            textAlign: TextAlign.center,
            style: SpookerFonts.s16BoldBlueCommon,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
              vertical: SpookerSize.m10, horizontal: SpookerSize.m20),
          alignment: Alignment.center,
          child: TextFormView(
            textController: _emailFieldController,
            textHint: SpookerStrings.emailAddressText,
            errorMessage: _viewModel.recoveryErrorMessage,
            isValidText: _viewModel.isValidText(),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(SpookerSize.m40),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              SpookerStrings.backToLogin,
              textAlign: TextAlign.center,
              style: SpookerFonts.s16BoldBlueCommon,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
              vertical: SpookerSize.m10, horizontal: SpookerSize.m20),
          alignment: Alignment.center,
          child: MainButtonView(
            buttonText: SpookerStrings.ContinueButtonText,
            isAvailable:  _viewModel.isRecoveryEmail,
            whenPress: () {
              context.showLoading();
              _viewModel
                  .recoverPassword()
                  .whenComplete(() => {_manageState(context)});
            },
          ),
        ),
      ], SpookerStrings.forgotPassword),
    );
  }

  void _manageState(BuildContext context) {
    Navigator.pop(context);
    if (_viewModel.isRecoverySuccess) {
      Navigator.pop(context);
    } else {
      context.showErrorDialog(SpookerErrorStrings.dialogWrong);
    }
  }

  void _initControllers() {
    _emailFieldController =
        useTextEditingController.fromValue(TextEditingValue.empty);
    _emailFieldController.addListener(() {
      _viewModel.validateRecoveryEmail(_emailFieldController.text);
    });
  }
}
