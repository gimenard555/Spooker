import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:spooker/ui/utils/spooker_sizes.dart';

import '../spooker_borders.dart';

class GlassMorphism extends StatelessWidget {
  final Widget child;
  final double start;
  final double end;

  const GlassMorphism({
    Key? key,
    required this.child,
    required this.start,
    required this.end,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(start),
                Colors.white.withOpacity(end),
              ],
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
            ),
            borderRadius: BorderRadius.only(
                topRight: SpookerBorders.m10Radius,
                topLeft: SpookerBorders.m10Radius),
            border: Border.all(
              width: SpookerSize.m2,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
