import 'package:flutter/cupertino.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';

class SpookerFonts {
  static const String montserratFont = "Montserrat";
  static const String painterzFont = "Painterz";
  static const double s12 = 12.0;
  static const double s14 = 14.0;
  static const double s16 = 16.0;
  static const double s18 = 18.0;
  static const double s20 = 20.0;
  static const double s24 = 24.0;
  static const double s96 = 96.0;

  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight bold = FontWeight.w700;

  static const TextStyle titleFirst = TextStyle(
      fontFamily: painterzFont, fontSize: s96, color: SpookerColors.darkBlue);

  static const TextStyle textFormError = TextStyle(
      fontFamily: montserratFont,
      fontSize: s18,
      fontWeight: regular,
      color: SpookerColors.errorRed);

  static const TextStyle s14BoldLight = TextStyle(
      fontFamily: montserratFont,
      fontSize: s14,
      fontWeight: bold,
      color: SpookerColors.completeLight);

  static const TextStyle dialogTitleError = TextStyle(
      fontFamily: montserratFont,
      fontSize: s20,
      fontWeight: bold,
      color: SpookerColors.errorRed);

  static const TextStyle s14RegularRed = TextStyle(
      fontFamily: montserratFont,
      fontSize: s14,
      fontWeight: regular,
      color: SpookerColors.errorRed);

  static const TextStyle s16MediumLight = TextStyle(
      fontFamily: montserratFont,
      fontSize: s16,
      fontWeight: medium,
      color: SpookerColors.completeLight);

  static const TextStyle textFormNormal = TextStyle(
      fontFamily: montserratFont,
      fontSize: s14,
      fontWeight: regular,
      color: SpookerColors.completeDark);

  static const TextStyle titleText = TextStyle(
      fontFamily: montserratFont,
      fontSize: s16,
      fontWeight: bold,
      color: SpookerColors.blueCommonTextColor);

  static const TextStyle topBarText = TextStyle(
      fontFamily: montserratFont,
      fontSize: s18,
      fontWeight: regular,
      color: SpookerColors.blueCommonTextColor);

  static const TextStyle blueTitleText = TextStyle(
      fontFamily: montserratFont,
      fontSize: s18,
      fontWeight: bold,
      color: SpookerColors.darkBlue);

  static const TextStyle blueButtonText = TextStyle(
      fontFamily: montserratFont,
      fontSize: s16,
      fontWeight: bold,
      color: SpookerColors.darkBlue);

  static const TextStyle lightTitleText = TextStyle(
      fontFamily: montserratFont,
      fontSize: s24,
      fontWeight: bold,
      color: SpookerColors.completeLight);

  static const TextStyle errorText = TextStyle(
      fontFamily: montserratFont,
      fontSize: s16,
      fontWeight: regular,
      color: SpookerColors.errorRed);

  static const TextStyle buttonNoAvailable = TextStyle(
      fontFamily: montserratFont,
      fontSize: s16,
      fontWeight: bold,
      color: SpookerColors.completeLight);

  static const TextStyle buttonAvailable = TextStyle(
      fontFamily: montserratFont,
      fontSize: s16,
      fontWeight: bold,
      color: SpookerColors.blueCommonTextColor);

  static const TextStyle s16BoldDarkBlue = TextStyle(
      fontFamily: montserratFont,
      fontSize: SpookerFonts.s16,
      fontWeight: bold,
      color: SpookerColors.darkBlue);

  static const TextStyle s20BoldCommonBlue = TextStyle(
      fontFamily: montserratFont,
      fontSize: SpookerFonts.s20,
      fontWeight: bold,
      color: SpookerColors.blueCommonTextColor);

  static const TextStyle tagText = TextStyle(
      fontFamily: montserratFont,
      fontSize: s12,
      fontWeight: medium,
      color: SpookerColors.lightGray);

  static const TextStyle dashboardTitleText = TextStyle(
      fontFamily: montserratFont,
      fontSize: s18,
      fontWeight: bold,
      color: SpookerColors.darkBlue);

  static const TextStyle unSelectedTitleText = TextStyle(
      fontFamily: montserratFont,
      fontSize: s18,
      fontWeight: medium,
      color: SpookerColors.darkBlue);

  static const TextStyle eventDateText = TextStyle(
      fontFamily: montserratFont,
      fontSize: s12,
      fontWeight: medium,
      color: SpookerColors.darkBlue);

  static const TextStyle eventNameText = TextStyle(
      fontFamily: montserratFont,
      fontSize: s24,
      fontWeight: bold,
      color: SpookerColors.blueCommonTextColor);

  static const TextStyle eventDescriptionText = TextStyle(
      fontFamily: montserratFont,
      fontSize: s12,
      fontWeight: regular,
      color: SpookerColors.blueCommonTextColor);
}
