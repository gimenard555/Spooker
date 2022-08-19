import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/components/main_screen_extension.dart';
import 'package:spooker/ui/screens/profile/profile_view_model.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';

import '../../../gen/assets.gen.dart';
import '../../components/outputs/custom_pager_view.dart';
import '../../components/outputs/custom_profile_background.dart';

// ignore: must_be_immutable
class ProfileScreen extends HookConsumerWidget {
  ProfileScreen({this.profileId = ''});

  late ProfileViewModel _viewModel;
  final String profileId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _viewModel = ref.watch(profileViewModel);
    _viewModel.getProfile(profileId: profileId);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              CustomProfileBackground(_viewModel.user?.image ?? '',
                  _viewModel.user?.username ?? '', profileId.isEmpty),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: SpookerSize.m20, vertical: SpookerSize.m20),
                  child: CustomPagerView(profileId: profileId),
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
