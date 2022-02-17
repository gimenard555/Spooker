import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:spooker/ui/components/buttons/main_button_view.dart';
import 'package:spooker/ui/screens/create_account_screen.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';
import 'package:spooker/ui/utils/spooker_strings.dart';

import 'login_screen.dart';

class FirstScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(color: SpookerColors.completeLight),
            height: double.infinity,
            width: double.infinity,
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.all(SpookerSize.paddingSize),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Lottie.asset('assets/animations/spooker_back.json',
                              width: screenHeight * 0.5,
                              height: screenHeight * 0.5,
                              fit: BoxFit.fill),
                          Container(
                            height: screenHeight * 0.2,
                            width: screenHeight * 0.2,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/main_logo.png'),
                                    fit: BoxFit.fill)),
                          ),
                        ],
                      ),
                      Text(
                        SpookerStrings.spookerAppName,
                        textAlign: TextAlign.center,
                        style: SpookerFonts.titleFirst,
                      ),
                      SizedBox(
                        height: SpookerSize.miniSizedBox,
                      ),
                      Text(
                        SpookerStrings.firstScreenText,
                        textAlign: TextAlign.center,
                        style: SpookerFonts.blueTitleText,
                      ),
                      SizedBox(
                        height: SpookerSize.sizedBoxSpace,
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
                        height: SpookerSize.miniSizedBox,
                      ),
                      MainButtonView(
                        buttonText: SpookerStrings.signUpText,
                        isAvailable: true,
                        whenPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateAccountScreen()),
                          );
                        },
                        isNormal: true,
                      ),
                      SizedBox(
                        height: SpookerSize.miniSizedBox,
                      ),
                      MainButtonView(
                        buttonText: SpookerStrings.signInGoogleText,
                        isAvailable: true,
                        whenPress: () {
                          _signInGooglePressed(context);
                        },
                        isNormal: true,
                      ),
                    ],
                  ),
                ))));
  }

  void _signInGooglePressed(BuildContext context) {}
}