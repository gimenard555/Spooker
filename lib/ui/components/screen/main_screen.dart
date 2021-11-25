import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:spooker/ui/components/Inputs/text_form_view.dart';
import 'package:spooker/ui/components/buttons/main_button_view.dart';
import 'package:spooker/ui/components/screen/glassmorphism.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';

import 'circle.dart';

class MainScreen extends HookWidget {
  MainScreen(this.children);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final _emailFieldController =
        useTextEditingController.fromValue(TextEditingValue.empty);

    return Scaffold(
      body: Container(
          color: SpookerColors.loginBackground,
          child: Stack(
            children: [
              new Center(
                child: new Stack(
                  children: <Widget>[
                    new Positioned(
                      child: new CircleButton(),
                      top: 10.0,
                      left: 130.0,
                    ),
                    new Positioned(
                      child: new CircleButton(),
                      top: 120.0,
                      left: 10.0,
                    ),
                    new Positioned(
                      child: new CircleButton(),
                      top: 120.0,
                      right: 10.0,
                    ),
                    new Positioned(
                      child: new CircleButton(),
                      top: 240.0,
                      left: 130.0,
                    ),
                    new Positioned(
                      child: new CircleButton(),
                      top: 120.0,
                      left: 130.0,
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
    final column = Column(children: [
      Align(
          alignment: Alignment.topCenter,
          child: Image(image: AssetImage('images/main_logo.png'))),
      Expanded(
        child: GlassMorphism(
          start: 0.9,
          end: 0.6,
          child: Padding(
              padding: EdgeInsets.all(SpookerSize.paddingSize),
              child: Column(
                children: [
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
                ],
              )),
        ),
      ),
    ]);
  }
}
