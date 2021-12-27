import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/components/Inputs/text_form_view.dart';
import 'package:spooker/ui/components/buttons/main_button_view.dart';
import 'package:spooker/ui/components/screen/authentication_background_screen.dart';
import 'package:spooker/ui/screens/create_account_view_model.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';
import 'package:spooker/ui/utils/spooker_strings.dart';
import 'package:spooker/ui/utils/strings_types.dart';

class CreateAccount extends HookConsumerWidget {
  late CreateAccountViewModel _viewModel;
  late TextEditingController _emailFieldController;
  late TextEditingController _usernameFieldController;
  late TextEditingController _birthdateFieldController;
  late TextEditingController _passwordFieldController;
  late TextEditingController _confirmPasswordFieldController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _viewModel = ref.watch(authViewModel);
    initAllTextEditing();
    return Scaffold(
      body: AuthenticationBackground([
        Align(
            alignment: Alignment.topCenter,
            child: Text(
              SpookerStrings.welcomeSignInText,
              textAlign: TextAlign.center,
              style: SpookerFonts.titleText,
            )),
        SizedBox(height: SpookerSize.sizedBoxSpace),
        Align(
            alignment: Alignment.center,
            child: TextFormView(
              textController: _emailFieldController,
              textHint: SpookerStrings.emailAddressText,
              errorMessage: _viewModel.errorMessage,
              isValidText: _viewModel.isValidText(),
            )),
        SizedBox(height: SpookerSize.sizedBoxSpace),
        Align(
            alignment: Alignment.center,
            child: TextFormView(
              textController: _usernameFieldController,
              textHint: SpookerStrings.usernameText,
              errorMessage: _viewModel.errorMessage,
              isValidText: _viewModel.isValidText(),
            )),
        SizedBox(height: SpookerSize.sizedBoxSpace),
        Align(
            alignment: Alignment.center,
            child: TextFormView(
              textController: _birthdateFieldController,
              textHint: SpookerStrings.birthdateText,
              errorMessage: _viewModel.errorMessage,
              isValidText: _viewModel.isValidText(),
            )),
        SizedBox(height: SpookerSize.sizedBoxSpace),
        Align(
            alignment: Alignment.center,
            child: TextFormView(
              textController: _passwordFieldController,
              textHint: SpookerStrings.passwordText,
              errorMessage: _viewModel.errorMessage,
              isValidText: _viewModel.isValidText(),
            )),
        SizedBox(height: SpookerSize.sizedBoxSpace),
        Align(
            alignment: Alignment.center,
            child: TextFormView(
              textController: _confirmPasswordFieldController,
              textHint: SpookerStrings.confirmPasswordText,
              errorMessage: _viewModel.errorMessage,
              isValidText: _viewModel.isValidText(),
            )),
        SizedBox(height: SpookerSize.sizedBoxSpace),
        MainButtonView(
          buttonText: SpookerStrings.ContinueButtonText,
          isAvailable: _viewModel.isValidText(),
          whenPress: _viewModel.signIn,
        ),
      ], ''),
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
    _viewModel.isTextAvailable(
        text: _emailFieldController.text, textType: TextType.IS_EMAIL);
  }

  void _manageUsernameChanges() {
    _viewModel.isTextAvailable(text: _usernameFieldController.text);
  }

  void _manageBirthdateChanges() {
    _viewModel.isTextAvailable(
        text: _birthdateFieldController.text, textType: TextType.IS_DATE);
  }

  void _managePasswordChanges() {
    _viewModel.isTextAvailable(
        text: _passwordFieldController.text, textType: TextType.IS_EMAIL);
  }

  void _manageConfirmPasswordChanges() {
    _viewModel.isTextAvailable(
        text: _confirmPasswordFieldController.text,
        textType: TextType.IS_PASSWORD);
  }
}
