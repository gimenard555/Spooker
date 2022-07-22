import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';

import '../../components/outputs/custom_profile_background.dart';
import '../../components/outputs/custom_title_text.dart';

class ProfileScreen extends HookConsumerWidget {
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
                imageProfile: image,
                screenName: "Profile",
                name: "Jimena Rojas",
              ),
              Container(
                margin: EdgeInsets.all(SpookerSize.m20),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Expanded(
                        child: CustomTextTitle(
                            titleText: "Artworks", highlight: true)),
                    Expanded(
                        child: CustomTextTitle(
                            titleText: "Events", highlight: false))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}