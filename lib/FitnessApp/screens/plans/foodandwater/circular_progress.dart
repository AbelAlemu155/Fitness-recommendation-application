import 'dart:ui';

import 'package:flutter/material.dart';

import 'dart:math' as Math;

class CircleProgressBar extends StatefulWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  double value;
  double begin;

  CircleProgressBar(
      {Key? key,
      this.backgroundColor = Colors.grey,
      required this.foregroundColor,
      required this.value,
      required this.begin})
      : super(key: key);

  @override
  CircleProgressBarState createState() {
    return CircleProgressBarState();
  }
}

class CircleProgressBarState extends State<CircleProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Tween<double>? valueTween;
  late Animation<double> curve;
  late double begin;
  late double val;

  @override
  void initState() {
    super.initState();
    begin = this.widget.begin;
    val = this.widget.value;
    this.controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    this.curve = CurvedAnimation(
      parent: this.controller,
      curve: Curves.easeInOut,
    );
    this.controller.forward();
  }

  @override
  void dispose() {
    this.controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CircleProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    this.valueTween = Tween<double>(
      begin: begin,
      end: val,
    );
    final backgroundColor = this.widget.backgroundColor;
    final foregroundColor = this.widget.foregroundColor;
    return Column(children: [
      Column(children: [
        AnimatedBuilder(
          animation: this.controller,
          child: Container(),
          builder: (context, child) {
            return CustomPaint(
              child: child,
              foregroundPainter: CircleProgressBarPainter(
                backgroundColor: backgroundColor,
                foregroundColor: foregroundColor,
                percentage: this.valueTween!.evaluate(this.controller),
              ),
            );
          },
        ),
      ]),
    ]);
  }
}

class CircleProgressBarPainter extends CustomPainter {
  final double percentage;
  final double strokeWidth = 13;
  final Color backgroundColor;
  final Color foregroundColor;

  CircleProgressBarPainter({
    this.backgroundColor = const Color.fromRGBO(212, 212, 212, 1),
    required this.foregroundColor,
    required this.percentage,
    double strokeWidth = 13,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);

    final Size constrainedSize =
        size - Offset(this.strokeWidth, this.strokeWidth) as Size;
    final double shortestSide =
        Math.min(constrainedSize.width, constrainedSize.height);
    final foregroundPaint = Paint()
      ..color = this.foregroundColor
      ..strokeWidth = this.strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final radius = 100.0;

    // Start at the top. 0 radians represents the right edge
    final double startAngle = -(2 * Math.pi * 0.25);
    final double sweepAngle = (2 * Math.pi * this.percentage);

    // Don't draw the background if we don't have a background color
    if (this.backgroundColor != null) {
      final backgroundPaint = Paint()
        ..color = this.backgroundColor
        ..strokeWidth = this.strokeWidth
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(center, radius, backgroundPaint);
    }

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final oldPainter = (oldDelegate as CircleProgressBarPainter);
    return oldPainter.percentage != this.percentage ||
        oldPainter.backgroundColor != this.backgroundColor ||
        oldPainter.foregroundColor != this.foregroundColor ||
        oldPainter.strokeWidth != this.strokeWidth;
  }
}
