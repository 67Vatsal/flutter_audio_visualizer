import 'package:flutter/material.dart';

abstract class AudioVisualizer extends StatelessWidget {
  final List<double> samples;
  final Color color;
  final double height;

  const AudioVisualizer({
    super.key,
    required this.samples,
    this.color = Colors.blue,
    this.height = 100,
  });
}
