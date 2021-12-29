import 'package:flutter/cupertino.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';

class SpookerFonts {
  static const String font = "Montserrat";
  static const double common18 = 18.0;
  static const double common16 = 16.0;
  static const double common24 = 24.0;

  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight bold = FontWeight.w700;

  static const TextStyle textFormHint = TextStyle(
      fontFamily: font,
      fontSize: common18,
      fontWeight: regular,
      color: SpookerColors.hintGray);

  static const TextStyle textFormError = TextStyle(
      fontFamily: font,
      fontSize: common18,
      fontWeight: regular,
      color: SpookerColors.errorRed);

  static const TextStyle textFormNormal = TextStyle(
      fontFamily: font,
      fontSize: common18,
      fontWeight: regular,
      color: SpookerColors.completeDark);

  static const TextStyle titleText = TextStyle(
      fontFamily: font,
      fontSize: common18,
      fontWeight: bold,
      color: SpookerColors.blueCommonTextColor);

  static const TextStyle lightTitleText = TextStyle(
      fontFamily: font,
      fontSize: common24,
      fontWeight: bold,
      color: SpookerColors.completeLight);

  static const TextStyle errorText = TextStyle(
      fontFamily: font,
      fontSize: common16,
      fontWeight: regular,
      color: SpookerColors.errorRed);

  static const TextStyle buttonNoAvailable = TextStyle(
      fontFamily: font,
      fontSize: common16,
      fontWeight: bold,
      color: SpookerColors.completeLight);

  static const TextStyle buttonAvailable = TextStyle(
      fontFamily: font,
      fontSize: common16,
      fontWeight: bold,
      color: SpookerColors.blueCommonTextColor);

  static const TextStyle commonGrayBold = TextStyle(
      fontFamily: font,
      fontSize: common16,
      fontWeight: bold,
      color: SpookerColors.darkGrayTextColor);
}
