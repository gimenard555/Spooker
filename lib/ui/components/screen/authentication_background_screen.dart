import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      body: Container(
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
                        Padding(
                          padding: EdgeInsets.all(SpookerSize.paddingSize),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  titleForm,
                                  textAlign: TextAlign.center,
                                  style: SpookerFonts.lightTitleText,
                                ),
                              ),
                              Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    height: screenHeight * 0.2,
                                    width: screenHeight * 0.2,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'images/main_logo.png'),
                                            fit: BoxFit.fill)),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Image(
                            width: screenWidth,
                            height: screenHeight * 0.8,
                            fit: BoxFit.contain,
                            image: AssetImage('images/paint.png'),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Padding(
                              padding: EdgeInsets.all(SpookerSize.paddingSize),
                              child: Column(
                                children: form,
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
