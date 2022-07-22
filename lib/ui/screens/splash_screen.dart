import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:spooker/gen/assets.gen.dart';
import 'package:spooker/ui/screens/first_screen.dart';

import '../utils/spooker_fonts.dart';
import '../utils/spooker_strings.dart';
import 'dashboard/dashboard_screen.dart';
import 'login/login_view_model.dart';

class SplashScreen extends HookConsumerWidget {
  late LoginViewModel _viewModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _viewModel = ref.watch(loginViewModelProvider);
    final _animationController =
        useAnimationController(duration: Duration(seconds: 20));
    return Scaffold(
        body: SafeArea(
            child: Stack(
      children: [
        Lottie.asset(
          Assets.animations.confettiSplash,
          controller: _animationController,
          animate: true,
          height: double.infinity,
          width: double.infinity,
          onLoaded: (composition) {
            _animationController
              ..duration = composition.duration
              ..forward().whenComplete(() =>
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => FirstScreen()),
                  ));
                  /*_viewModel.isSomeoneSignIn().then((value) {
                    if (value) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashboardScreen()),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => FirstScreen()),
                      );
                    }
                  }));*/
          },
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.images.mainLogo.image(),
              Text(
                SpookerStrings.spookerAppName,
                textAlign: TextAlign.center,
                style: SpookerFonts.titleFirst,
              ),
            ],
          ),
        )
      ],
    )));
  }
}
