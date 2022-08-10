import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/components/main_screen_extension.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';

import '../../../gen/assets.gen.dart';
import '../../components/outputs/custom_pager_view.dart';
import '../../components/outputs/custom_profile_background.dart';

class ProfileScreen extends HookConsumerWidget {
  ProfileScreen(this._isMyProfile);

  final bool _isMyProfile;

  final String image =
      "https://media.istockphoto.com/photos/portrait-of-smiling-mixed-race-woman-looking-at-camera-picture-id1319763830?b=1&k=20&m=1319763830&s=170667a&w=0&h=wE44n9yP1nrefeqv5DCl5mE3ouU01FNNHeZPR0yDCWA=";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              CustomProfileBackground(
                  image, "Profile", _isMyProfile),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: SpookerSize.m20, vertical: SpookerSize.m20),
                  child: CustomPagerView(),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: SpookerColors.spookerBlue,
        child: Assets.images.add.image(),
        onPressed: () {
          context.showOptions();
        },
      ),
    );
  }
}
