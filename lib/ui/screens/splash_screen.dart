import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController();
    return Scaffold(
      backgroundColor: SpookerColors.loginBackground,
      body: Lottie.asset('assets/animations/confetti_splash.json',
          controller: animationController,
          height: MediaQuery.of(context).size.height * 1,
          animate: true, onLoaded: (composition) {
        animationController
          ..duration = composition.duration
          ..forward().whenComplete(() => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => SplashScreen())));
      }),
    );
  }
}
