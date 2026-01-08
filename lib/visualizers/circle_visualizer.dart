import 'dart:math';
import 'package:flutter/material.dart';

class CircleVisualizer extends StatelessWidget {
  /// Audio amplitude samples (0.0 → 1.0)
  final List<double> samples;

  /// Bar color
  final Color color;

  /// Size of the visualizer
  final double size;

  /// Minimum radius of the circle
  final double minRadius;

  /// Maximum height of bars
  final double maxBarHeight;

  /// Thickness of each bar
  final double barWidth;

  /// Whether bars animate smoothly
  final bool smooth;

  const CircleVisualizer({
    super.key,
    required this.samples,
    this.color = Colors.blue,
    this.size = 200,
    this.minRadius = 60,
    this.maxBarHeight = 40,
    this.barWidth = 3,
    this.smooth = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _CircleVisualizerPainter(
          samples: samples,
          color: color,
          minRadius: minRadius,
          maxBarHeight: maxBarHeight,
          barWidth: barWidth,
          smooth: smooth,
        ),
      ),
    );
  }
}

class _CircleVisualizerPainter extends CustomPainter {
  final List<double> samples;
  final Color color;
  final double minRadius;
  final double maxBarHeight;
  final double barWidth;
  final bool smooth;

  _CircleVisualizerPainter({
    required this.samples,
    required this.color,
    required this.minRadius,
    required this.maxBarHeight,
    required this.barWidth,
    required this.smooth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = color
      ..strokeWidth = barWidth
      ..strokeCap = StrokeCap.round;

    final angleStep = (2 * pi) / samples.length;

    for (int i = 0; i < samples.length; i++) {
      final value = samples[i].clamp(0.0, 1.0);
      final barHeight = value * maxBarHeight;

      final angle = i * angleStep;

      final start = Offset(
        center.dx + minRadius * cos(angle),
        center.dy + minRadius * sin(angle),
      );

      final end = Offset(
        center.dx + (minRadius + barHeight) * cos(angle),
        center.dy + (minRadius + barHeight) * sin(angle),
      );

      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _CircleVisualizerPainter oldDelegate) {
    return smooth || oldDelegate.samples != samples;
  }
}
