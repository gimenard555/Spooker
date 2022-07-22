import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/gen/assets.gen.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';
import '../../screens/profile/profile_screen.dart';
import '../spooker_borders.dart';

typedef GoToProfile = void Function();

typedef GoToNotifications = void Function();

typedef GoStartMySpooker = void Function();

class CustomTopBar extends HookConsumerWidget {
  CustomTopBar({required this.goToProfile});

  final GoToProfile goToProfile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: SpookerSize.m80,
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.all(SpookerSize.m8),
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
                  goToProfile();
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
                    style: SpookerFonts.topBarText),
              ),
              Expanded(child: SizedBox()),
              Container(
                  margin: EdgeInsets.all(SpookerSize.m20),
                  child: Assets.images.notifications.image()),
              Container(
                  margin: EdgeInsets.all(SpookerSize.m20),
                  child: Assets.images.configuration.image()),
            ],
          ),
        ),
      ),
    );
  }
}