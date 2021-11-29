import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/components/Inputs/text_form_view.dart';
import 'package:spooker/ui/components/buttons/main_button_view.dart';
import 'package:spooker/ui/components/screen/authentication_background_screen.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';
import 'package:spooker/ui/utils/spooker_strings.dart';
import 'package:spooker/ui/utils/strings_types.dart';

class LoginScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _emailFieldController =
        useTextEditingController.fromValue(TextEditingValue.empty);

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
              textType: TextType.IS_EMAIL,
              textHint: SpookerStrings.emailAddressText,
            )),
        SizedBox(height: SpookerSize.sizedBoxSpace),
        MainButtonView(
          buttonText: SpookerStrings.ContinueButtonText,
        )
      ]),
    );
  }
}
