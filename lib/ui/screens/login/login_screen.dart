import 'package:firebase_auth/firebase_auth.dart';
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
import '../dashboard/dashboard_screen.dart';

// ignore: must_be_immutable
class LoginScreen extends HookConsumerWidget {
  late LoginViewModel _viewModel;
  late TextEditingController _emailFieldController;
  late TextEditingController _passwordFieldController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _viewModel = ref.watch(loginViewModelProvider);
    var user = ref.watch(loginViewModelProvider.select((value) => value.user));
    //Texform email
    _emailFieldController =
        useTextEditingController.fromValue(TextEditingValue.empty);
    _emailFieldController.addListener(_manageEmailChanges);
    //Texform password
    _passwordFieldController =
        useTextEditingController.fromValue(TextEditingValue.empty);
    _passwordFieldController.addListener(_managePasswordChanges);
    return Scaffold(
      body: AuthenticationBackground([
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(SpookerSize.m20),
          child: Text(
            SpookerStrings.welcomeSignInText,
            textAlign: TextAlign.center,
            style: SpookerFonts.titleText,
          ),
        ),
        Container(
            margin: EdgeInsets.symmetric(
                vertical: SpookerSize.m10, horizontal: SpookerSize.m20),
            alignment: Alignment.center,
            child: TextFormView(
              textController: _emailFieldController,
              textHint: SpookerStrings.emailAddressText,
              errorMessage: _viewModel.errorMessage,
              isValidText: _viewModel.isValidText(),
            )),
        Container(
            margin: EdgeInsets.symmetric(
                vertical: SpookerSize.m10, horizontal: SpookerSize.m20),
            alignment: Alignment.center,
            child: TextFormView(
              textController: _passwordFieldController,
              textHint: SpookerStrings.passwordText,
              errorMessage: SpookerStrings.emptyString,
              isValidText: _viewModel.isValidPass(),
              isPassword: true,
            )),
        Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(SpookerSize.m40),
            child: InkWell(
              onTap: () {},
              child: Text(
                SpookerStrings.passwordForgotten,
                textAlign: TextAlign.center,
                style: SpookerFonts.titleText,
              ),
            )),
        Container(
            margin: EdgeInsets.symmetric(
                vertical: SpookerSize.m10, horizontal: SpookerSize.m20),
            alignment: Alignment.center,
            child: MainButtonView(
              buttonText: SpookerStrings.ContinueButtonText,
              isAvailable: _viewModel.isDataComplete,
              whenPress: () {
                _viewModel.signIn().whenComplete(() {
                  _navigateToDashboard(user, context);
                });
              },
            )),
      ], SpookerStrings.signInText),
    );
  }

  void _manageEmailChanges() {
    _viewModel.isTextAvailable(_emailFieldController.text, TextType.IS_EMAIL);
  }

  void _managePasswordChanges() {
    _viewModel.validatePassword(_passwordFieldController.text);
  }

  void _navigateToDashboard(User? user, BuildContext context) {
    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    }
  }
}
