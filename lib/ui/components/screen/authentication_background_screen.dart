import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spooker/gen/assets.gen.dart';
import 'package:spooker/ui/components/screen/main_curve_background.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';

class AuthenticationBackground extends StatelessWidget {
  AuthenticationBackground(this.form, this.titleForm);

  final List<Widget> form;
  final String titleForm;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        reverse: true,
        child: Container(
            color: SpookerColors.completeLight,
            child: Stack(
              children: [
                Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: screenHeight * 0.3,
                            width: screenWidth,
                            child: CustomPaint(
                              painter: MainCurve(),
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: EdgeInsets.all(SpookerSize.m8),
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Assets.images.backButton.image()),
                              )),
                          Padding(
                            padding: EdgeInsets.all(SpookerSize.m20),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    titleForm,
                                    textAlign: TextAlign.center,
                                    style: SpookerFonts.s24BoldLight,
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.topCenter,
                                    child: Assets.images.mainLogo.image()),
                              ],
                            ),
                          )
                        ],
                      ),
                      Stack(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                                  children: form,
                                ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    ));
  }
}
