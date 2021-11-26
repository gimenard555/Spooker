import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:spooker/ui/components/screen/glassmorphism.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';

import 'circle.dart';

class AuthenticationBackground extends HookWidget {
  AuthenticationBackground(this.form);

  final List<Widget> form;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: SpookerColors.loginBackground,
          child: Stack(
            children: [
              Center(
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: CircleButton(),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: CircleButton(),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CircleButton(),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: CircleButton(),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CircleButton(),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.3),
                child: GlassMorphism(
                  start: 0.9,
                  end: 0.6,
                  child: Padding(
                      padding: EdgeInsets.all(SpookerSize.paddingSize),
                      child: Column(
                        children: form,
                      )),
                ),
              )),
              Align(
                  alignment: Alignment.topCenter,
                  child: Image(image: AssetImage('images/main_logo.png'))),
            ],
          )),
    );
  }
}
