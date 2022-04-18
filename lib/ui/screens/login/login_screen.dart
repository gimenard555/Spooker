import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/components/Inputs/text_form_view.dart';
import 'package:spooker/ui/components/buttons/main_button_view.dart';
import 'package:spooker/ui/components/screen/authentication_background_screen.dart';
import 'package:spooker/ui/screens/login/login_view_model.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';
import 'package:spooker/ui/utils/spooker_strings.dart';
import 'package:spooker/ui/utils/strings_types.dart';

// ignore: must_be_immutable
class LoginScreen extends HookConsumerWidget {
  late LoginViewModel _viewModel;
  late TextEditingController _emailFieldController;
  late TextEditingController _passwordFieldController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _viewModel = ref.watch(loginViewModel);
    _emailFieldController =
        useTextEditingController.fromValue(TextEditingValue.empty);
    _emailFieldController.addListener(_manageEmailChanges);
    _passwordFieldController =
        useTextEditingController.fromValue(TextEditingValue.empty);
    _emailFieldController.addListener(_managePasswordChanges);
    return Scaffold(
      body: AuthenticationBackground([
        Align(
            alignment: Alignment.topCenter,
            child: Text(
              SpookerStrings.welcomeSignInText,
              textAlign: TextAlign.center,
              style: SpookerFonts.titleText,
            )),
        SizedBox(height: SpookerSize.m20),
        Align(
            alignment: Alignment.center,
            child: TextFormView(
              textController: _emailFieldController,
              textHint: SpookerStrings.emailAddressText,
              errorMessage: _viewModel.errorMessage,
              isValidText: _viewModel.isValidText(),
            )),
        SizedBox(height: SpookerSize.m20),
        Align(
            alignment: Alignment.center,
            child: TextFormView(
              textController: _passwordFieldController,
              textHint: SpookerStrings.passwordText,
              errorMessage: '',
              isValidText: _viewModel.isValidPass(),
              isPassword: true,
            )),
        SizedBox(height: SpookerSize.m20),
        MainButtonView(
          buttonText: SpookerStrings.ContinueButtonText,
          isAvailable: _viewModel.isDataComplete(),
          whenPress: (){
            _viewModel.getAllEvents();
          },
        ),
      ], SpookerStrings.signInText),
    );
  }

  void _manageEmailChanges() {
    _viewModel.isTextAvailable(_emailFieldController.text, TextType.IS_EMAIL);
  }

  void _managePasswordChanges() {
    _viewModel.validatePassword(_passwordFieldController.text);
  }
}
