import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/components/Inputs/text_form_view.dart';
import 'package:spooker/ui/components/main_screen_extension.dart';
import 'package:spooker/ui/components/screen/authentication_background_screen.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';
import 'package:spooker/ui/utils/spooker_strings.dart';

import '../../components/buttons/common_button_view.dart';
import '../../utils/spooker_colors.dart';
import '../dashboard/dashboard_screen.dart';
import 'create_account_view_model.dart';

// ignore: must_be_immutable
class CreateAccountScreen extends HookConsumerWidget {
  late CreateAccountViewModel _viewModel;
  late TextEditingController _emailFieldController;
  late TextEditingController _usernameFieldController;
  late TextEditingController _passwordFieldController;
  late TextEditingController _confirmPasswordFieldController;
  late TextEditingController _birthdateFieldController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _viewModel = ref.watch(createAccountViewModel);
    _initAllTextEditing();
    return Scaffold(
      body: AuthenticationBackground([
        Container(
            margin: EdgeInsets.all(SpookerSize.m20),
            alignment: Alignment.topCenter,
            child: Text(
              SpookerStrings.welcomeSignUpText,
              textAlign: TextAlign.center,
              style: SpookerFonts.s16BoldBlueCommon,
            )),
        Container(
            margin: EdgeInsets.symmetric(
                horizontal: SpookerSize.m20, vertical: SpookerSize.m5),
            alignment: Alignment.center,
            child: TextFormView(
              textController: _emailFieldController,
              textHint: SpookerStrings.emailAddressText,
              errorMessage: _viewModel.errorEmailMessage,
              isValidText: _viewModel.isValidEmail(),
            )),
        Container(
            margin: EdgeInsets.symmetric(
                horizontal: SpookerSize.m20, vertical: SpookerSize.m5),
            alignment: Alignment.center,
            child: TextFormView(
              textController: _usernameFieldController,
              textHint: SpookerStrings.usernameText,
              errorMessage: _viewModel.errorUsernameMessage,
              isValidText: _viewModel.isValidUsername(),
            )),
        Container(
            margin: EdgeInsets.symmetric(
                horizontal: SpookerSize.m20, vertical: SpookerSize.m5),
            alignment: Alignment.center,
            child: TextFormView(
              textController: _birthdateFieldController,
              textHint: SpookerStrings.birthdateText,
              errorMessage: '',
              isValidText: _viewModel.birthdate.isNotEmpty,
              onTouchText: () {
                FocusManager.instance.primaryFocus?.unfocus();
                context.showDateDialog((date, dateTime) {
                  _viewModel.saveBirthdate(date);
                  _birthdateFieldController.text = date;
                });
              },
            )),
        Container(
            margin: EdgeInsets.symmetric(
                horizontal: SpookerSize.m20, vertical: SpookerSize.m5),
            alignment: Alignment.center,
            child: TextFormView(
              textController: _passwordFieldController,
              textHint: SpookerStrings.passwordText,
              errorMessage: _viewModel.errorPasswordMessage,
              isValidText: _viewModel.isValidPassword(),
            )),
        Container(
            margin: EdgeInsets.symmetric(
                horizontal: SpookerSize.m20, vertical: SpookerSize.m5),
            alignment: Alignment.center,
            child: TextFormView(
              textController: _confirmPasswordFieldController,
              textHint: SpookerStrings.confirmPasswordText,
              errorMessage: _viewModel.errorConfirmedPasswordMessage,
              isValidText: _viewModel.isValidConfirmedPass(),
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
                  .createAccount()
                  .whenComplete(() => {_manageState(context)});
            },
            isAvailable: _viewModel.isDataCompleted(),
          ),
        ),
      ], SpookerStrings.signUpText),
    );
  }

  void _manageState(BuildContext context) {
    Navigator.pop(context);
    if (_viewModel.isAuthenticated) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    } else {
      context.showErrorDialog(SpookerErrorStrings.dialogWrong);
    }
  }

  void _initAllTextEditing() {
    _emailFieldController =
        useTextEditingController.fromValue(TextEditingValue.empty);
    _emailFieldController.addListener(_manageEmailChanges);

    _usernameFieldController =
        useTextEditingController.fromValue(TextEditingValue.empty);
    _usernameFieldController.addListener(_manageUsernameChanges);

    _birthdateFieldController =
        useTextEditingController.fromValue(TextEditingValue.empty);

    _passwordFieldController =
        useTextEditingController.fromValue(TextEditingValue.empty);
    _passwordFieldController.addListener(_managePasswordChanges);

    _confirmPasswordFieldController =
        useTextEditingController.fromValue(TextEditingValue.empty);
    _confirmPasswordFieldController.addListener(_manageConfirmPasswordChanges);
  }

  void _manageEmailChanges() {
    _viewModel.isEmailAvaliable(_emailFieldController.text);
  }

  void _manageUsernameChanges() {
    _viewModel.isUsernameAvaliable(_usernameFieldController.text);
  }

  void _managePasswordChanges() {
    _viewModel.isPasswordAvaliable(_passwordFieldController.text);
  }

  void _manageConfirmPasswordChanges() {
    _viewModel
        .isConfirmedPasswordAvaliable(_confirmPasswordFieldController.text);
  }
}
