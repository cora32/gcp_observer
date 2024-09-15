import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:gcp_observer/utils/strings.dart';
import 'package:gcp_observer/widgets/gcp_panel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// final getIt = GetIt.instance;

void main() {
  setup();

  runApp(const MyApp());
}

void setup() {
  // getIt.registerSingleton<Rest>(Rest());
  // getIt.registerSingleton<Repo>(Repo());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.name,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber).copyWith(
            background: const Color(0xFF0E2657),
            onBackground: const Color(0xFF0E2657),
            surface: const Color(0xFF0E2657),
            onSurface: const Color(0xFF0E2657)),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: BG(
          Center(
            child: ProviderScope(child: GCPPanel()),
          ),
        ),
      ),
    );
  }
}

class BG extends StatelessWidget {
  final Widget child;

  const BG(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width - 16;
    double height = MediaQuery.sizeOf(context).height;
    var padding = MediaQuery.paddingOf(context);
    double newHeight = height - padding.top - padding.bottom;
    double chartHeight = 70;

    return CustomPaint(
      painter: BGPainter(width, newHeight),
      child: child,
    );
  }
}

class BGPainter extends CustomPainter {
  final double width;
  final double height;

  late final paint1 = Paint()
    // ..color = Colors.white10
    ..strokeCap = StrokeCap.round
    ..isAntiAlias = true
    ..strokeWidth = 0.1
    ..strokeJoin = StrokeJoin.round
    ..style = PaintingStyle.stroke
    ..shader = ui.Gradient.linear(const Offset(0.5, 0), Offset(0.5, height), [
      const Color(0x15ffffff),
      const Color(0x0affffff),
      const Color(0x06ffffff),
    ], [
      0.0,
      0.2,
      1.0
    ]);
  late final xStep = width / 20;
  late final yStep = height / 25;

  BGPainter(this.width, this.height);

  @override
  void paint(Canvas canvas, Size size) {
    for (var x = xStep; x <= size.width + xStep; x += xStep) {
      for (var y = 0.0; y <= size.height + yStep; y += yStep) {
        final pv1 = Offset(x, 0);
        final pv2 = Offset(x, height + yStep);

        drawDashedLine(
            canvas: canvas,
            p1: pv1,
            p2: pv2,
            pattern: const [5, 5],
            paint: paint1);

        final ph1 = Offset(0, y);
        final ph2 = Offset(width + xStep, y);
        drawDashedLine(
            canvas: canvas,
            p1: ph1,
            p2: ph2,
            pattern: const [5, 5],
            paint: paint1);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void drawDashedLine({
    required Canvas canvas,
    required Offset p1,
    required Offset p2,
    required Iterable<double> pattern,
    required Paint paint,
  }) {
    assert(pattern.length.isEven);
    final distance = (p2 - p1).distance;
    final normalizedPattern = pattern.map((width) => width / distance).toList();
    final points = <Offset>[];
    double t = 0;
    int i = 0;
    while (t < 1) {
      points.add(Offset.lerp(p1, p2, t)!);
      t += normalizedPattern[i++]; // dashWidth
      points.add(Offset.lerp(p1, p2, t.clamp(0, 1))!);
      t += normalizedPattern[i++]; // dashSpace
      i %= normalizedPattern.length;
    }
    canvas.drawPoints(ui.PointMode.lines, points, paint);
  }
}
