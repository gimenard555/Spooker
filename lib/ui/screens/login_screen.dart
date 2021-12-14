import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/components/Inputs/text_form_view.dart';
import 'package:spooker/ui/components/buttons/main_button_view.dart';
import 'package:spooker/ui/components/screen/authentication_background_screen.dart';
import 'package:spooker/ui/screens/login_screen_view_model.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';
import 'package:spooker/ui/utils/spooker_strings.dart';
import 'package:spooker/ui/utils/strings_types.dart';

// ignore: must_be_immutable
class LoginScreen extends HookConsumerWidget {
  late LoginViewModel _state;
  late TextEditingController _emailFieldController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _state = ref.watch(loginViewModel);
    _state.textType = TextType.IS_EMAIL;
    _emailFieldController =
        useTextEditingController.fromValue(TextEditingValue.empty);
    _emailFieldController.addListener(_manageTextChanges);
    return Scaffold(
      body: AuthenticationBackground([
        Align(
            alignment: Alignment.topCenter,
            child: Text(
              SpookerStrings.welcomeText,
              textAlign: TextAlign.center,
              style: SpookerFonts.titleText,
            )),
        SizedBox(height: SpookerSize.sizedBoxSpace),
        Align(
            alignment: Alignment.center,
            child: TextFormView(
              textController: _emailFieldController,
              textHint: SpookerStrings.emailAddressText,
              errorMessage: _state.errorMessage,
              isValidText: _state.isValidText,
            )),
        SizedBox(height: SpookerSize.sizedBoxSpace),
        MainButtonView(
          buttonText: SpookerStrings.ContinueButtonText,
          isAvailable: _state.isValidText,
          whenPress: _state.signIn,
        ),
      ]),
    );
  }

  void _manageTextChanges() {
    _state.isTextAvailable(_emailFieldController.text);
  }
}
