import 'package:flutter/material.dart';
import 'dart:math';

class WaveVisualizer extends StatelessWidget {
  final List<double> samples;
  final Color color;
  final double height;
  final double strokeWidth;

  const WaveVisualizer({
    super.key,
    required this.samples,
    this.color = Colors.blue,
    this.height = 100,
    this.strokeWidth = 2,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: _WavePainter(
          samples: samples,
          color: color,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  final List<double> samples;
  final Color color;
  final double strokeWidth;

  _WavePainter({
    required this.samples,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (samples.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();

    /// 🔹 Fit samples to width
    final pointCount = size.width ~/ 4;
    final usableSamples = samples.length > pointCount
        ? samples.sublist(0, pointCount)
        : samples;

    for (int i = 0; i < usableSamples.length; i++) {
      final x = size.width * i / (usableSamples.length - 1);

      /// 🔹 CENTER samples (-1 → +1)
      final centered = (usableSamples[i] * 2) - 1;

      final y = size.height / 2 -
          centered.clamp(-1.0, 1.0) * size.height / 2;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        final prevX =
            size.width * (i - 1) / (usableSamples.length - 1);
        final prevY = size.height / 2 -
            (((usableSamples[i - 1] * 2) - 1)
                .clamp(-1.0, 1.0)) *
                size.height / 2;

        path.quadraticBezierTo(
          prevX,
          prevY,
          x,
          y,
        );
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _WavePainter oldDelegate) {
    return oldDelegate.samples != samples ||
        oldDelegate.color != color;
  }
}
