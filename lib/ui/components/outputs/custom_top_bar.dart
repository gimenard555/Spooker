import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/gen/assets.gen.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'package:spooker/ui/utils/spooker_fonts.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';

import '../../screens/profile/profile_view_model.dart';
import '../../utils/spooker_strings.dart';
import '../spooker_borders.dart';

typedef GoToProfile = void Function();

typedef GoToReminder = void Function();

typedef GoStartMySpooker = void Function();

// ignore: must_be_immutable
class CustomTopBar extends HookConsumerWidget {
  CustomTopBar(this._goToProfile, this._goToReminder, this._goToSpooker);

  final GoToProfile _goToProfile;
  final GoToReminder _goToReminder;
  final GoStartMySpooker _goToSpooker;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _viewModel = ref.watch(profileViewModel);
    _viewModel.getProfile();
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
                      backgroundImage:
                          NetworkImage(_viewModel.user?.image ?? ''),
                    )),
              ),
              Container(
                margin: EdgeInsets.all(SpookerSize.m5),
                child: Text(_viewModel.user?.name ?? SpookerStrings.EMPTY,
                    style: SpookerFonts.s18RegularBlueCommon),
              ),
              Expanded(child: SizedBox()),
              InkWell(
                onTap: () {
                  _goToReminder();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: SpookerSize.m10),
                  child: Assets.images.notifications.image(),
                ),
              ),
              InkWell(
                onTap: () {
                  _goToSpooker();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: SpookerSize.m10),
                  child: Assets.images.configuration.image(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
