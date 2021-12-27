import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/components/Inputs/text_form_view.dart';
import 'package:spooker/ui/components/buttons/main_button_view.dart';
import 'package:spooker/ui/components/screen/authentication_background_screen.dart';
import 'package:spooker/ui/screens/login_view_model.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';
import 'package:spooker/ui/utils/spooker_strings.dart';
import 'package:spooker/ui/utils/strings_types.dart';

class LoginScreen extends HookConsumerWidget {
  late LoginViewModel _viewModel;
  late TextEditingController _emailFieldController;
  late TextEditingController _passwordFieldController;
  bool isPassword = false;
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
              textController: _passwordFieldController,
              textHint: SpookerStrings.passwordText,
              errorMessage: null,
              isValidText: isPassword,
              isPassword: true,
            )),
        SizedBox(height: SpookerSize.sizedBoxSpace),
        MainButtonView(
          buttonText: SpookerStrings.ContinueButtonText,
          isAvailable: _viewModel.isValidText(),
          whenPress: _viewModel.signIn,
        ),
      ], SpookerStrings.signInText),
    );
  }

  void _manageEmailChanges() {
    _viewModel.isTextAvailable(_emailFieldController.text, TextType.IS_EMAIL);
  }

  void _managePasswordChanges() {
    if (_emailFieldController.text.isNotEmpty) {
      isPassword = true;
    } else {
      isPassword = false;
    }
  }
}
