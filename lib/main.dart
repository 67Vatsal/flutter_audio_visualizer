import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_audio_visualizer/flutter_audio_visualizer.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: VisualizerDemo()),
      ),
    );
  }
}

class VisualizerDemo extends StatefulWidget {
  @override
  State<VisualizerDemo> createState() => _VisualizerDemoState();
}

class _VisualizerDemoState extends State<VisualizerDemo> {
  List<double> samples = List.generate(40, (_) => Random().nextDouble());

  @override
  void initState() {
    super.initState();
    Stream.periodic(const Duration(milliseconds: 100)).listen((_) {
      setState(() {
        samples = List.generate(40, (_) => Random().nextDouble());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Visualizer'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// 🔹 FIRST ROW → Bar + Circle
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Bar Visualizer
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Bar',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        BarVisualizer(
                          samples: samples,
                          color: Colors.orange,
                          height: 120,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                /// Circle Visualizer
                Container(
                  width: 180,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Circle',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      CircleVisualizer(
                        samples: samples,
                        color: Colors.white,
                        size: 140,
                        minRadius: 45,
                        maxBarHeight: 35,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// 🔹 SECOND ROW → Wave Visualizer (Full Width)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text(
                    'Wave',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  WaveVisualizer(
                    samples: samples,
                    color: Colors.green,
                    height: 120,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// 🔹 SECOND ROW → Wave Visualizer (Full Width)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text(
                    'Mirror Bar',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  MirrorBarVisualizer(
                    samples: samples,
                    color: Colors.blueAccent,
                    height: 120,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
