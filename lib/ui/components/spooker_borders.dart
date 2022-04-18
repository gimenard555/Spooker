import 'package:flutter/cupertino.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';

class SpookerBorders {
  static const Radius zeroRadius = Radius.circular(SpookerSize.zero);
  static const Radius m20Radius = Radius.circular(SpookerSize.m20);
  static const Radius m10Radius = Radius.circular(SpookerSize.m10);

  static const BorderRadius borderRadiusLeft = const BorderRadius.only(
      topRight: zeroRadius,
      topLeft: m20Radius,
      bottomLeft: m20Radius,
      bottomRight: zeroRadius);

  static const BorderRadius borderRadiusRight = const BorderRadius.only(
      topRight: m20Radius,
      topLeft: zeroRadius,
      bottomLeft: zeroRadius,
      bottomRight: m20Radius);

  static const BorderRadius borderRadiusTop = const BorderRadius.only(
    topRight: m10Radius,
    topLeft: m10Radius,
    bottomLeft: zeroRadius,
    bottomRight: zeroRadius,
  );

  static BorderRadius borderRadiusAll = BorderRadius.circular(SpookerSize.m10);
  static BorderRadius borderTag = BorderRadius.circular(SpookerSize.m20);
  static BorderRadius m30Border = BorderRadius.circular(SpookerSize.m30);
  static BorderRadius m10Border = BorderRadius.circular(SpookerSize.m10);
}
