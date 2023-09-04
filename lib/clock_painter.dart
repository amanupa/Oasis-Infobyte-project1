import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' show radians;
import 'dart:math';


class ClockVisual extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final center = Offset(centerX, centerY);

    final radius = min(centerX, centerY);

    final now = DateTime.now();
    final hour = now.hour % 12;
    final minute = now.minute;
    final second = now.second;

    // the clock face
    final facePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, facePaint);

    // the clock outline
    final outlinePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;
    canvas.drawCircle(center, radius, outlinePaint);

    // the hour hand
    final hourAngle = radians(360 / 12 * hour - 90);
    final hourX = centerX + radius * 0.4 * cos(hourAngle);
    final hourY = centerY + radius * 0.4 * sin(hourAngle);
    final hourHandPaint = Paint()
      ..color = const Color.fromARGB(255, 147, 242, 196)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;
    canvas.drawLine(center, Offset(hourX, hourY), hourHandPaint);

    // the minute hand
    final minuteAngle = radians(360 / 60 * minute - 90);
    final minuteX = centerX + radius * 0.6 * cos(minuteAngle);
    final minuteY = centerY + radius * 0.6 * sin(minuteAngle);
    final minuteHandPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;
    canvas.drawLine(center, Offset(minuteX, minuteY), minuteHandPaint);

    // the second hand
    final secondAngle = radians(360 / 60 * second - 90);
    final secondX = centerX + radius * 0.6 * cos(secondAngle);
    final secondY = centerY + radius * 0.6 * sin(secondAngle);
    final secondHandPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawLine(center, Offset(secondX, secondY), secondHandPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}