import 'package:flutter/material.dart';
class MirrorBarVisualizer extends StatelessWidget {
  final List<double> samples;
  final Color color;
  final double height;

  const MirrorBarVisualizer({
    super.key,
    required this.samples,
    this.color = Colors.blue,
    this.height = 100,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: samples.map((value) {
          final barHeight = (height / 2) * value.clamp(0.0, 1.0);
          return Container(
            width: 3,
            margin: const EdgeInsets.symmetric(horizontal: 1),
            child: Column(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: barHeight,
                      color: color,
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: barHeight,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
