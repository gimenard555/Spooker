import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:spooker/ui/components/buttons/main_button_view.dart';
import 'package:spooker/ui/screens/create_account/create_account_screen.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';
import 'package:spooker/ui/utils/spooker_strings.dart';

import '../../gen/assets.gen.dart';
import 'login/login_screen.dart';

class FirstScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
            body: Container(
                decoration: BoxDecoration(color: SpookerColors.completeLight),
                height: double.infinity,
                width: double.infinity,
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.all(SpookerSize.m20),
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Lottie.asset(Assets.animations.spookerBack,
                                  width: screenHeight * 0.5,
                                  height: screenHeight * 0.5,
                                  fit: BoxFit.fill),
                              Container(
                                height: screenHeight * 0.2,
                                width: screenHeight * 0.2,
                                child: Assets.images.mainLogo.image(),
                              ),
                            ],
                          ),
                          Text(
                            SpookerStrings.spookerAppName,
                            textAlign: TextAlign.center,
                            style: SpookerFonts.titleFirst,
                          ),
                          SizedBox(
                            height: SpookerSize.m8,
                          ),
                          Text(
                            SpookerStrings.firstScreenText,
                            textAlign: TextAlign.center,
                            style: SpookerFonts.blueTitleText,
                          ),
                          SizedBox(
                            height: SpookerSize.m20,
                          ),
                          MainButtonView(
                            buttonText: SpookerStrings.loginText,
                            isAvailable: true,
                            whenPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                              );
                            },
                          ),
                          SizedBox(
                            height: SpookerSize.m8,
                          ),
                          MainButtonView(
                            buttonText: SpookerStrings.signUpText,
                            isAvailable: true,
                            whenPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CreateAccountScreen()),
                              );
                            },
                            isNormal: true,
                          ),
                          SizedBox(
                            height: SpookerSize.m8,
                          ),
                          MainButtonView(
                            buttonText: SpookerStrings.signInGoogleText,
                            isAvailable: true,
                            whenPress: () {
                              _signInGooglePressed(context);
                            },
                            isNormal: true,
                            buttonImage: Assets.images.googleIcon.image(),
                          ),
                        ],
                      ),
                    )))));
  }


  void _signInGooglePressed(BuildContext context) {}
}
