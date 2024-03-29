import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:spooker/ui/components/spooker_borders.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';
import 'package:spooker/ui/utils/spooker_strings.dart';

import '../../../gen/assets.gen.dart';
import '../../screens/profile/profile_settings_screen.dart';
import '../../utils/spooker_fonts.dart';
import '../screen/main_curve_background.dart';

class CustomProfileBackground extends StatelessWidget {
  CustomProfileBackground(this._imageProfile, this._name, this._isMyProfile);

  final String _imageProfile;
  final String _name;
  final bool _isMyProfile;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: screenHeight * 0.3,
                width: screenWidth,
                child: CustomPaint(
                  painter: MainCurve(),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.all(SpookerSize.m10),
                  alignment: Alignment.topLeft,
                  child: Assets.images.backButton.image(),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(top: SpookerSize.m10),
                child: Column(
                  children: [
                    Text(
                      SpookerStrings.profile,
                      textAlign: TextAlign.center,
                      style: SpookerFonts.s24BoldLight,
                    ),
                    SizedBox(
                      height: SpookerSize.m20,
                    ),
                    Container(
                      width: screenWidth * 0.4,
                      height: screenWidth * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: SpookerBorders.m200Border,
                        gradient: SpookerColors.rightGradient,
                      ),
                      child: Container(
                        margin: EdgeInsets.all(SpookerSize.m5),
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: screenWidth * 0.2,
                          backgroundImage: NetworkImage(this._imageProfile),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              getSettingsByFlag(context),
            ],
          ),
          Container(
            child: Text(_name,
                textAlign: TextAlign.center,
                style: SpookerFonts.s24BoldBlueCommon),
          ),
        ],
      ),
    );
  }

  Widget getSettingsByFlag(BuildContext context) {
    if (_isMyProfile) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileSettingsScreen()),
          );
        },
        child: Container(
          margin: EdgeInsets.all(SpookerSize.m10),
          alignment: Alignment.topRight,
          child: Assets.images.settings.image(),
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
