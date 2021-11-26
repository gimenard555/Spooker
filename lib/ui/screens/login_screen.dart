import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/components/Inputs/text_form_view.dart';
import 'package:spooker/ui/components/buttons/main_button_view.dart';
import 'package:spooker/ui/components/screen/authentication_background_screen.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';

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
              'WELCOME BACK',
              textAlign: TextAlign.center,
              style: SpookerFonts.titleText,
            )),
        SizedBox(height: SpookerSize.sizedBoxSpace),
        Align(
            alignment: Alignment.topCenter,
            child: TextFormView(
                textController: _emailFieldController,
                textHint: 'Ingrese su nombre')),
        SizedBox(height: SpookerSize.sizedBoxSpace),
        Align(
            alignment: Alignment.topCenter,
            child: TextFormView(
                textController: _emailFieldController,
                textHint: 'Ingrese su correo')),
        SizedBox(height: SpookerSize.sizedBoxSpace),
        MainButtonView(
          buttonText: 'CONTINUAR',
        )
      ]),
    );
  }
}
