import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';

class CircleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width / 5;
    return new InkResponse(
        child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          gradient: SpookerColors.rightGradient,
          shape: BoxShape.circle,
        ),
      ),
    ));
  }
}
