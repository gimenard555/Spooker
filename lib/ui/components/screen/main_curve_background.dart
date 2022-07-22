import 'package:flutter/cupertino.dart';
import 'package:spooker/ui/utils/spooker_colors.dart';

class MainCurve extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final paint = Paint()
      ..color = SpookerColors.spookerBlue
      ..style = PaintingStyle.fill
      ..strokeWidth = 10;

    final path = Path()
      ..lineTo(0, height * 0.9) //Comienzo
      ..quadraticBezierTo(
          width / 6, height * 0.7, width / 3, height * 0.85) // first up curve
      ..quadraticBezierTo((width / 6) * 3, height, (width / 3) * 2,
          height * 0.85) // middle curve
      ..quadraticBezierTo(
          (width / 6) * 5, height * 0.7, width, height * 0.9) //Second up curve
      ..lineTo(width, 0); //Final
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
