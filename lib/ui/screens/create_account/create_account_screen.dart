import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:spooker/ui/components/Inputs/text_form_view.dart';
import 'package:spooker/ui/components/buttons/main_button_view.dart';
import 'package:spooker/ui/components/dialogs/spooker_dialog.dart';
import 'package:spooker/ui/components/screen/authentication_background_screen.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';
import 'package:spooker/ui/utils/spooker_strings.dart';

import 'create_account_view_model.dart';

// ignore: must_be_immutable
class CreateAccountScreen extends HookConsumerWidget {
  late CreateAccountViewModel _viewModel;
  late TextEditingController _emailFieldController;
  late TextEditingController _usernameFieldController;
  late TextEditingController _birthdateFieldController;
  late TextEditingController _passwordFieldController;
  late TextEditingController _confirmPasswordFieldController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _viewModel = ref.watch(createAccountViewModel);
    initAllTextEditing();
    return Scaffold(
      body: AuthenticationBackground([
        Align(
            alignment: Alignment.topCenter,
            child: Text(
              SpookerStrings.welcomeSignUpText,
              textAlign: TextAlign.center,
              style: SpookerFonts.titleText,
            )),
        SizedBox(height: SpookerSize.sizedBoxSpace),
        Align(
            alignment: Alignment.center,
            child: TextFormView(
              textController: _emailFieldController,
              textHint: SpookerStrings.emailAddressText,
              errorMessage: _viewModel.errorEmailMessage,
              isValidText: _viewModel.isValidEmail(),
            )),
        SizedBox(height: SpookerSize.sizedBoxSpace),
        Align(
            alignment: Alignment.center,
            child: TextFormView(
              textController: _usernameFieldController,
              textHint: SpookerStrings.usernameText,
              errorMessage: _viewModel.errorUsernameMessage,
              isValidText: _viewModel.isValidUsername(),
            )),
        SizedBox(height: SpookerSize.sizedBoxSpace),
        Align(
            alignment: Alignment.center,
            child: TextFormView(
              textController: _birthdateFieldController,
              textHint: SpookerStrings.birthdateText,
              errorMessage: '',
              isValidText: false,
              onTouchText: () {
                showBirthdateDialog(context);
              },
            )),
        SizedBox(height: SpookerSize.sizedBoxSpace),
        Align(
            alignment: Alignment.center,
            child: TextFormView(
              textController: _passwordFieldController,
              textHint: SpookerStrings.passwordText,
              errorMessage: _viewModel.errorPasswordMessage,
              isValidText: _viewModel.isValidPassword(),
            )),
        SizedBox(height: SpookerSize.sizedBoxSpace),
        Align(
            alignment: Alignment.center,
            child: TextFormView(
              textController: _confirmPasswordFieldController,
              textHint: SpookerStrings.confirmPasswordText,
              errorMessage: _viewModel.errorConfirmedPasswordMessage,
              isValidText: _viewModel.isValidConfirmedPass(),
            )),
        SizedBox(height: SpookerSize.sizedBoxSpace),
        MainButtonView(
          buttonText: SpookerStrings.ContinueButtonText,
          isAvailable: _viewModel.isDataCompleted(),
          whenPress: () {},
        ),
      ], SpookerStrings.signUpText),
    );
  }

  void initAllTextEditing() {
    _emailFieldController =
        useTextEditingController.fromValue(TextEditingValue.empty);
    _emailFieldController.addListener(_manageEmailChanges);

    _usernameFieldController =
        useTextEditingController.fromValue(TextEditingValue.empty);
    _usernameFieldController.addListener(_manageUsernameChanges);

    _birthdateFieldController =
        useTextEditingController.fromValue(TextEditingValue.empty);
    _birthdateFieldController.addListener(_manageBirthdateChanges);

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

  void _manageBirthdateChanges() {}

  void _managePasswordChanges() {
    _viewModel.isPasswordAvaliable(_passwordFieldController.text);
  }

  void _manageConfirmPasswordChanges() {
    _viewModel
        .isConfirmedPasswordAvaliable(_confirmPasswordFieldController.text);
  }

  void showBirthdateDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return SpookerDialog([
            Padding(
              padding: EdgeInsets.only(top: SpookerSize.paddingSize),
              child: TextFormView(
                textController: _birthdateFieldController,
                textHint: SpookerStrings.birthdateText,
                errorMessage: '',
                isValidText: false,
              ),
            ),
            Theme(
              data: ThemeData.light().copyWith(
                  primaryColor: SpookerColors.spookerGreen,
                  textTheme: TextTheme(
                      bodyText1: SpookerFonts.titleText,
                      bodyText2: SpookerFonts.blueTitleText)),
              child: CalendarDatePicker(
                initialDate: DateTime.now(),
                firstDate: DateTime.now().add(Duration(days: -5114)),
                lastDate: DateTime.now(),
                onDateChanged: (DateTime selectedDate) {
                  _birthdateFieldController.text =
                      DateFormat('dd MMMM yyyy').format(selectedDate);
                },
              ),
            ),
            MainButtonView(
              buttonText: SpookerStrings.dateSelectionButtonText,
              isAvailable: true,
              whenPress: () {
                Navigator.of(context).pop(false);
              },
            ),
          ], SpookerStrings.birthdateSelectionText);
        },
        barrierDismissible: false);
  }
}
