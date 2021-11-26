import 'package:flutter/material.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';

class CircleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width / 5;
    return new InkResponse(
      child: new Container(
        width: size,
        height: size,
        decoration: new BoxDecoration(
          gradient: SpookerColors.rightGradient,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
