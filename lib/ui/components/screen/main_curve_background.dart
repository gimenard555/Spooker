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
      ..lineTo(0, size.height * 0.8)
      ..quadraticBezierTo(width / 6, height * 0.5, width / 3, height * 0.8)
      ..quadraticBezierTo((width / 6) * 3, height + (height * 0.2),
          (width / 3) * 2, height * 0.8)
      ..quadraticBezierTo((width / 6) * 5, height * 0.5, width, height * 0.8)
      ..lineTo(size.width, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
