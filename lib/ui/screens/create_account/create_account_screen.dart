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
  late TextEditingController _wholeNameController;

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
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: SpookerSize.m20, vertical: SpookerSize.m5),
          alignment: Alignment.center,
          child: TextFormView(
            textController: _emailFieldController,
            textHint: SpookerStrings.emailAddressText,
            errorMessage: _viewModel.errorEmailMessage,
            isValidText: _viewModel.isValidEmail(),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: SpookerSize.m20, vertical: SpookerSize.m5),
          alignment: Alignment.center,
          child: TextFormView(
            textController: _wholeNameController,
            textHint: SpookerStrings.nameText,
            errorMessage: SpookerStrings.EMPTY,
            isValidText: _viewModel.isWholeName,
            isCapitalize: true,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: SpookerSize.m20, vertical: SpookerSize.m5),
          alignment: Alignment.center,
          child: TextFormView(
            textController: _usernameFieldController,
            textHint: SpookerStrings.usernameText,
            errorMessage: _viewModel.errorUsernameMessage,
            isValidText: _viewModel.isValidUsername(),
            isCapitalize: true,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: SpookerSize.m20, vertical: SpookerSize.m5),
          alignment: Alignment.center,
          child: TextFormView(
            textController: _birthdateFieldController,
            textHint: SpookerStrings.birthdateText,
            errorMessage: SpookerStrings.EMPTY,
            isValidText: _viewModel.birthdate.isNotEmpty,
            onTouchText: () {
              FocusManager.instance.primaryFocus?.unfocus();
              context.showDateDialog((date, dateTime) {
                _viewModel.saveBirthdate(date);
                _birthdateFieldController.text = date;
              }, isBefore: true, firstDateAge: 18, lastDateAge: 14);
            },
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: SpookerSize.m20, vertical: SpookerSize.m5),
          alignment: Alignment.center,
          child: TextFormView(
            textController: _passwordFieldController,
            textHint: SpookerStrings.passwordText,
            errorMessage: _viewModel.errorPasswordMessage,
            isValidText: _viewModel.isValidPassword(),
            isPassword: true,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: SpookerSize.m20, vertical: SpookerSize.m5),
          alignment: Alignment.center,
          child: TextFormView(
            textController: _confirmPasswordFieldController,
            textHint: SpookerStrings.confirmPasswordText,
            errorMessage: _viewModel.errorConfirmedPasswordMessage,
            isValidText: _viewModel.isValidConfirmedPass(),
            isPassword: true,
          ),
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
    _emailFieldController.addListener(() {
      _viewModel.isEmailAvaliable(_emailFieldController.text);
    });

    _wholeNameController =
        useTextEditingController.fromValue(TextEditingValue.empty);
    _wholeNameController.addListener(() {
      _viewModel.wholeName = _wholeNameController.text;
    });

    _usernameFieldController =
        useTextEditingController.fromValue(TextEditingValue.empty);
    _usernameFieldController.addListener(() {
      _viewModel.isUsernameAvaliable(_usernameFieldController.text);
    });

    _birthdateFieldController =
        useTextEditingController.fromValue(TextEditingValue.empty);

    _passwordFieldController =
        useTextEditingController.fromValue(TextEditingValue.empty);
    _passwordFieldController.addListener(() {
      _viewModel.isPasswordAvaliable(_passwordFieldController.text);
    });

    _confirmPasswordFieldController =
        useTextEditingController.fromValue(TextEditingValue.empty);
    _confirmPasswordFieldController.addListener(() {
      _viewModel
          .isConfirmedPasswordAvaliable(_confirmPasswordFieldController.text);
    });
  }
}
