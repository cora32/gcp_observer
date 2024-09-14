import 'package:flutter/material.dart';

import 'dart:ui' as ui;
import 'package:gcp_observer/repo/repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'chart.dart';

class GCPDot extends ConsumerWidget {
  const GCPDot({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(getParsedGcpDataProvider);

    print('--> $result');

    return switch (result) {
      AsyncData(:final value) => ContentScreen(value),
      AsyncError(:final error) => ErrorScreen(error),
      _ => const LoadingScreen(),
    };

    // return ErrorScreen("s");
  }
}

class ErrorScreen extends StatelessWidget {
  final Object? error;

  const ErrorScreen(this.error, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      child: Center(
        child: Text(
          error.toString(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class ContentScreen extends StatelessWidget {
  final GCPData data;

  const ContentScreen(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    var padding = MediaQuery.paddingOf(context);
    // double newHeight = height - padding.top - padding.bottom;
    double chartHeight = 100;

    return Padding(
      padding: EdgeInsets.only(top: padding.top + 8, bottom: 9),
      child: Column(
        children: [
          // Dot
          CustomPaint(
            size: const Size(100, 100),
            painter: GCPPainter(data.dataA.last, 100),
          ),
          const Spacer(),
          // Chart
          Chart(data.dataA, width, chartHeight),
          Chart(data.dataB, width, chartHeight),
          Chart(data.dataQ1, width, chartHeight),
          Chart(data.dataQ3, width, chartHeight),
          Chart(data.dataT, width, chartHeight),
        ],
      ),
    );
  }
}

class GCPPainter extends CustomPainter {
  final double value;
  final double height;
  final paint1 = Paint()
    ..color = Colors.amber
    ..strokeCap = StrokeCap.round
    ..isAntiAlias = true
    ..strokeWidth = 10
    ..strokeJoin = StrokeJoin.round
    ..style = PaintingStyle.fill;

  GCPPainter(
    this.value,
    this.height,
  ) {
    paint1.shader = ui.Gradient.linear(
        const Offset(0.5, 0),
        Offset(0.5, height),
        [
          // const Color(0xffCDCDCD),
          // const Color(0xffFFA8C0),
          const Color(0xffFF1E1E),
          const Color(0xffFFB82E),
          const Color(0xffFFD517),
          const Color(0xffFFFA40),
          const Color(0xffF9FA00),
          const Color(0xffAEFA00),
          const Color(0xff64FA64),
          const Color(0xff64FAAB),
          const Color(0xffACF2FF),
          const Color(0xff0EEEFF),
          const Color(0xff24CBFD),
          const Color(0xff5655CA),
        ],
        List.generate(12, (i) => 0.03 * i));

    final shader = ui.Gradient.linear(
        const Offset(0.5, 0),
        Offset(0.5, height),
        [
          // const Color(0xffCDCDCD),
          // const Color(0xffFFA8C0),
          const Color(0xffFF1E1E),
          const Color(0xffFFB82E),
          const Color(0xffFFD517),
          const Color(0xffFFFA40),
          const Color(0xffF9FA00),
          const Color(0xffAEFA00),
          const Color(0xff64FA64),
          const Color(0xff64FAAB),
          const Color(0xffACF2FF),
          const Color(0xff0EEEFF),
          const Color(0xff24CBFD),
          const Color(0xff5655CA),
        ],
        List.generate(12, (i) => 0.03 * i));
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
