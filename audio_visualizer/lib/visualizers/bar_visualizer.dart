import 'package:flutter/material.dart';
import 'visualizer_base.dart';

class BarVisualizer extends AudioVisualizer {
  final double barWidth;
  final double spacing;

  const BarVisualizer({
    super.key,
    required super.samples,
    super.color,
    super.height,
    this.barWidth = 3,
    this.spacing = 2,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;

        /// total space taken by one bar
        final barSpace = barWidth + spacing;

        /// how many bars can fit in container
        final maxBars = (maxWidth / barSpace).floor();

        /// downsample audio data to fit width
        final visibleSamples = samples.length > maxBars
            ? samples.sublist(0, maxBars)
            : samples;

        return SizedBox(
          height: height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: visibleSamples.map((value) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: spacing / 2),
                child: Container(
                  width: barWidth,
                  height: height * value.clamp(0.0, 1.0),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
