import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/gen/assets.gen.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';

import '../spooker_borders.dart';

typedef GoToProfile = void Function();

typedef GoToReminder = void Function();

typedef GoStartMySpooker = void Function();

class CustomTopBar extends HookConsumerWidget {
  CustomTopBar(this._goToProfile, this._goToReminder);

  final GoToProfile _goToProfile;
  final GoToReminder _goToReminder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: SpookerSize.m60,
      width: double.infinity,
      child: Card(
        elevation: SpookerSize.m5,
        color: SpookerColors.completeLight,
        shape: RoundedRectangleBorder(borderRadius: SpookerBorders.m30Border),
        child: Container(
          decoration: BoxDecoration(
              gradient: SpookerColors.topBarGradient,
              borderRadius: SpookerBorders.m30Border),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  _goToProfile();
                },
                child: Container(
                    margin: EdgeInsets.all(SpookerSize.m5),
                    width: SpookerSize.m50,
                    height: SpookerSize.m50,
                    child: CircleAvatar(
                      radius: SpookerSize.m20,
                      backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80",
                      ),
                    )),
              ),
              Container(
                margin: EdgeInsets.all(SpookerSize.m5),
                child: Text("Jimenard Rojas Duarte",
                    style: SpookerFonts.s18RegularBlueCommon),
              ),
              Expanded(child: SizedBox()),
              InkWell(
                onTap: () {
                  _goToReminder();
                },
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: SpookerSize.m10),
                    child: Assets.images.notifications.image()),
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: SpookerSize.m10),
                  child: Assets.images.configuration.image()),
            ],
          ),
        ),
      ),
    );
  }
}
