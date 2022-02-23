import 'package:flutter/cupertino.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';

class SpookerFonts {
  static const String montserratFont = "Montserrat";
  static const String painterzFont = "Painterz";
  static const double common12 = 12.0;
  static const double common14 = 14.0;
  static const double common16 = 16.0;
  static const double common18 = 18.0;
  static const double common24 = 24.0;
  static const double common96 = 96.0;

  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight bold = FontWeight.w700;

  static const TextStyle titleFirst = TextStyle(
      fontFamily: painterzFont,
      fontSize: common96,
      color: SpookerColors.darkBlue);

  static const TextStyle textFormHint = TextStyle(
      fontFamily: montserratFont,
      fontSize: common18,
      fontWeight: regular,
      color: SpookerColors.hintGray);

  static const TextStyle textFormError = TextStyle(
      fontFamily: montserratFont,
      fontSize: common18,
      fontWeight: regular,
      color: SpookerColors.errorRed);

  static const TextStyle textFormNormal = TextStyle(
      fontFamily: montserratFont,
      fontSize: common18,
      fontWeight: regular,
      color: SpookerColors.completeDark);

  static const TextStyle titleText = TextStyle(
      fontFamily: montserratFont,
      fontSize: common18,
      fontWeight: bold,
      color: SpookerColors.blueCommonTextColor);

  static const TextStyle blueTitleText = TextStyle(
      fontFamily: montserratFont,
      fontSize: common18,
      fontWeight: bold,
      color: SpookerColors.darkBlue);

  static const TextStyle blueButtonText = TextStyle(
      fontFamily: montserratFont,
      fontSize: common16,
      fontWeight: bold,
      color: SpookerColors.darkBlue);

  static const TextStyle lightTitleText = TextStyle(
      fontFamily: montserratFont,
      fontSize: common24,
      fontWeight: bold,
      color: SpookerColors.completeLight);

  static const TextStyle errorText = TextStyle(
      fontFamily: montserratFont,
      fontSize: common16,
      fontWeight: regular,
      color: SpookerColors.errorRed);

  static const TextStyle buttonNoAvailable = TextStyle(
      fontFamily: montserratFont,
      fontSize: common16,
      fontWeight: bold,
      color: SpookerColors.completeLight);

  static const TextStyle buttonAvailable = TextStyle(
      fontFamily: montserratFont,
      fontSize: common16,
      fontWeight: bold,
      color: SpookerColors.blueCommonTextColor);

  static const TextStyle commonGrayBold = TextStyle(
      fontFamily: montserratFont,
      fontSize: common16,
      fontWeight: bold,
      color: SpookerColors.darkGrayTextColor);

  static const TextStyle artworkItemText = TextStyle(
      fontFamily: montserratFont,
      fontSize: common14,
      fontWeight: bold,
      color: SpookerColors.blueCommonTextColor);

  static const TextStyle dashboardTitleText = TextStyle(
      fontFamily: montserratFont,
      fontSize: common18,
      fontWeight: bold,
      color: SpookerColors.blueCommonTextColor);
}
