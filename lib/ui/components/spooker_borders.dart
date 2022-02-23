import 'package:flutter/cupertino.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';

class SpookerBorders {
  static BorderRadius borderRadiusAll =
      BorderRadius.circular(SpookerSize.borderRadius);
  static BorderRadius borderRadiusTop = const BorderRadius.only(
    topRight: Radius.circular(SpookerSize.borderRadius),
    topLeft: Radius.circular(SpookerSize.borderRadius),
    bottomLeft: Radius.circular(SpookerSize.zero),
    bottomRight: Radius.circular(SpookerSize.zero),
  );
}
