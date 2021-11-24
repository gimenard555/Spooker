import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
class SpookerColors {
  static const Color loginBackground = Color(0xFFF4FFF3);
  static const Color completeLight = Color(0xFFFFFFEF);
  static const Color spookerGreen = Color(0xFFF4F440);
  static const Color spookerBlue = Color(0xFF6BDBE4);
  static const Color spookerYellow = Color(0xFFFFDD55);
  static const Color spookerMainGreen = Color(0xFFD4FF2A);
  static const Color errorRed = Color(0xFFFF795D);
  static const Color lightGray = Color(0xFFF1F1F1);
  static const Color darkBlue = Color(0xFF1B4F72);
  static const Color hintGray = Color(0xFFB0B0B0);
  static const Color completeDark = Color(0xFF000000);

  static const LinearGradient rightGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [spookerBlue, spookerGreen]);
}
