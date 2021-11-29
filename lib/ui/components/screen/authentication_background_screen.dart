import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spooker/ui/components/screen/glassmorphism.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';

import 'circle.dart';

class AuthenticationBackground extends StatelessWidget {
  AuthenticationBackground(this.form);

  final List<Widget> form;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
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
              Padding(
                padding: EdgeInsets.only(top: (screenHeight ~/ 5) / 2),
                child: GlassMorphism(
                  start: 0.5,
                  end: 0.3,
                  child: Padding(
                      padding: EdgeInsets.only(
                          top: screenHeight / 5,
                          bottom: SpookerSize.paddingSize,
                          right: SpookerSize.paddingSize,
                          left: SpookerSize.paddingSize),
                      child: Column(
                        children: form,
                      )),
                ),
              ),
              Align(
                  alignment: Alignment.topCenter,
                  child: Image(
                      image: ResizeImage(AssetImage('images/main_logo.png'),
                          width: screenHeight ~/ 5,
                          height: screenHeight ~/ 5))),
            ],
          )),
    );
  }
}
