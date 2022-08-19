import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spooker/ui/components/image/image.dart';
import 'package:spooker/ui/components/top_bar_view.dart';
import 'package:spooker/ui/screens/profile/profile_view_model.dart';
import 'package:spooker/ui/utils/spooker_strings.dart';

import '../../components/Inputs/text_form_view.dart';
import '../../components/buttons/common_button_view.dart';
import '../../components/spooker_borders.dart';
import '../../utils/spooker_colors.dart';
import '../../utils/spooker_fonts.dart';
import '../../utils/spooker_sizes.dart';

// ignore: must_be_immutable
class ProfileSettingsScreen extends HookConsumerWidget {
  late ProfileViewModel _viewModel;
  late TextEditingController _currentPassword;
  late TextEditingController _newPassword;
  late TextEditingController _repeatPassword;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _viewModel = ref.watch(profileViewModel);
    _viewModel.getMyProfile();
    final screenWidth = MediaQuery.of(context).size.width;
    _initControllers();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TopBarView(SpookerStrings.profile),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: SpookerSize.m20, vertical: SpookerSize.m10),
                width: screenWidth * 0.4,
                height: screenWidth * 0.4,
                decoration: BoxDecoration(
                  borderRadius: SpookerBorders.m200Border,
                  gradient: SpookerColors.rightGradient,
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: screenWidth * 0.2,
                    backgroundImage: networkImage(_viewModel.user?.image ?? '',
                            fit: BoxFit.cover)
                        .image,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: SpookerSize.m20),
                child: Text(_viewModel.user?.username ?? '',
                    textAlign: TextAlign.center,
                    style: SpookerFonts.s20BoldCommonBlue),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: SpookerSize.m20),
                child: Text(_viewModel.user?.name ?? '',
                    textAlign: TextAlign.center,
                    style: SpookerFonts.s20BoldDarkBlue),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: SpookerSize.m20),
                child: Text(_viewModel.user?.emailAddress ?? '',
                    textAlign: TextAlign.center,
                    style: SpookerFonts.s16RegularBlueCommon),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: SpookerSize.m20,
                    bottom: SpookerSize.m5,
                    left: SpookerSize.m20,
                    right: SpookerSize.m20),
                alignment: Alignment.center,
                child: TextFormView(
                  textController: _currentPassword,
                  textHint: SpookerStrings.currentPassword,
                  errorMessage: SpookerStrings.emptyString,
                  isValidText: false,
                  isPassword: true,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: SpookerSize.m5, horizontal: SpookerSize.m20),
                alignment: Alignment.center,
                child: TextFormView(
                  textController: _newPassword,
                  textHint: SpookerStrings.newPassword,
                  errorMessage: SpookerStrings.emptyString,
                  isValidText: false,
                  isPassword: true,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: SpookerSize.m5, horizontal: SpookerSize.m20),
                alignment: Alignment.center,
                child: TextFormView(
                  textController: _repeatPassword,
                  textHint: SpookerStrings.repeatNewPassword,
                  errorMessage: SpookerStrings.emptyString,
                  isValidText: false,
                  isPassword: true,
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: SpookerSize.m20),
                child: CommonButtonView(
                  SpookerColors.noAvailableColor,
                  SpookerStrings.updatePassword,
                  SpookerFonts.s16BoldLight,
                  () {},
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                    horizontal: SpookerSize.m20, vertical: SpookerSize.m5),
                child: CommonButtonView(
                  SpookerColors.blueCommonTextColor,
                  SpookerStrings.logOut,
                  SpookerFonts.s16BoldLight,
                  () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _initControllers() {
    _currentPassword =
        useTextEditingController.fromValue(TextEditingValue.empty);
    _repeatPassword =
        useTextEditingController.fromValue(TextEditingValue.empty);
    _newPassword = useTextEditingController.fromValue(TextEditingValue.empty);
  }
}
