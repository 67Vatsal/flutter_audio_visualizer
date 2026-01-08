## Flutter Audio Visualizer

A **highly customizable audio visualizer library for Flutter**.  
Supports multiple visualizations such as **Bar**, **Circle**, **Wave**, and **Mirror bars**.  

This library is **UI-only**, allowing you to plug in any audio source, signal, or sample list.

---

## Features

- 🎨 Multiple visualizer styles:
  - Bar Visualizer
  - Circle Visualizer
  - Wave Visualizer
  - Mirror Bar Visualizer
- ⚡ Lightweight and efficient
- 🔧 Fully customizable colors, height, and size
- ✅ Works with any source of numerical samples (0.0 → 1.0)
- 🖥️ Compatible with Flutter 3.0+

---

## Installation

Add the dependency in your `pubspec.yaml`:


yaml
```
dependencies:
  flutter_audio_visualizer: ^1.0.0
```

  Then run:
```
  flutter pub get
```

## Usage
Step 1: Import
```
import 'package:flutter_audio_visualizer/flutter_audio_visualizer.dart';
```
Step 2: Create a controller
```
final controller = AudioVisualizerController();
```
Step 3: Feed samples
The library works with any list of double values between 0.0 and 1.0.
For example, to generate demo values:
```
controller.addSamples(List.generate(64, (index) => Random().nextDouble()));
```
Step 4: Add visualizers
```
VisualizerBuilder(
  controller: controller,
  builder: (_, samples) => BarVisualizer(
    samples: samples,
    color: Colors.greenAccent,
    height: 120,
  ),
),

VisualizerBuilder(
  controller: controller,
  builder: (_, samples) => CircleVisualizer(
    samples: samples,
    color: Colors.redAccent,
  ),
),

VisualizerBuilder(
  controller: controller,
  builder: (_, samples) => WaveVisualizer(
    samples: samples,
    color: Colors.blueAccent,
    height: 120,
  ),
),
```
## Example: Full main.dart
```
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_audio_visualizer/flutter_audio_visualizer.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Demo(),
    );
  }
}

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  final controller = AudioVisualizerController();

  @override
  void initState() {
    super.initState();

    // Example: generate random samples periodically
    Stream.periodic(const Duration(milliseconds: 80)).listen((_) {
      controller.addSamples(
        List.generate(64, (_) => Random().nextDouble()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Audio Visualizer')),
      body: Column(
        children: [
          SizedBox(
            height: 140,
            width: double.infinity,
            child: VisualizerBuilder(
              controller: controller,
              builder: (_, s) => BarVisualizer(
                samples: s,
                color: Colors.greenAccent,
                height: 120,
              ),
            ),
          ),

          SizedBox(
            height: 180,
            width: double.infinity,
            child: VisualizerBuilder(
              controller: controller,
              builder: (_, s) => CircleVisualizer(
                samples: s,
                color: Colors.redAccent,
              ),
            ),
          ),

          SizedBox(
            height: 140,
            width: double.infinity,
            child: VisualizerBuilder(
              controller: controller,
              builder: (_, s) => WaveVisualizer(
                samples: s,
                color: Colors.blueAccent,
                height: 120,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```
## 📁 PROJECT STRUCTURE

```
flutter_audio_visualizer/
│
├── lib/
├── Visualizer/
│   │   ├── bar_visualizer.dart
│   │   ├── circle_visualizer.dart
│   │   ├── wave_visualizer.dart
│   │   └── mirror_bar_visualizer.dart
│   ├── flutter_audio_visualizer.dart   # main export
│   │── main.dart

```

## License
```
MIT License

Copyright (c) 2025 Excelsior Technologies

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
```
