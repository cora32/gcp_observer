import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:gcp_observer/repo/repo.dart';
import 'package:gcp_observer/utils/params.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utils/strings.dart';
import '../utils/utils.dart';
import 'gcp_panel.dart';

class GCPSlider extends ConsumerStatefulWidget {
  const GCPSlider({super.key});

  @override
  ConsumerState<GCPSlider> createState() => _GcpSliderState();
}

class _GcpSliderState extends ConsumerState<GCPSlider> {
  @override
  Widget build(BuildContext context) {
    final result = ref.watch(getParsedGcpDataProvider);

    print('--> GCPSlider: $result.');

    return switch (result) {
      AsyncData(:final value) => _ContentScreen(value.value),
      AsyncError(:final error) => ErrorScreen(error),
      _ => const LoadingScreen(),
    };
  }
}

class _ContentScreen extends StatefulWidget {
  final double value;

  const _ContentScreen(this.value, {super.key});

  @override
  State<_ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<_ContentScreen>
    with SingleTickerProviderStateMixin {
  late final end = widget.value;
  late final controller =
      AnimationController(duration: const Duration(seconds: 5), vsync: this);
  late final anim = Tween(begin: prevValue, end: end).animate(controller);
  var value = 0.0;
  var prevValue = 0.0;
  final style = GoogleFonts.lato(
    fontSize: 13,
    color: Colors.white70,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
  );
  GlobalKey key1 = GlobalKey();
  GlobalKey key2 = GlobalKey();
  GlobalKey key3 = GlobalKey();
  GlobalKey key4 = GlobalKey();
  GlobalKey key5 = GlobalKey();
  GlobalKey key6 = GlobalKey();

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller
      ..addListener(() {
        setState(() {
          value = anim.value;
        });
      })
      ..forward();

    // prevValue = end;
  }

  @override
  Widget build(BuildContext context) {
    const width = 80.0;
    const height = 500.0;

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(key: key1, Strings.gcpDesc05, style: style),
              const SizedBox(
                height: 16,
              ),
              Text(key: key2, Strings.gcpDesc510, style: style),
              const SizedBox(
                height: 16,
              ),
              Text(key: key3, Strings.gcpDesc1040, style: style),
              const SizedBox(
                height: 16,
              ),
              Text(key: key4, Strings.gcpDesc4090, style: style),
              const SizedBox(
                height: 16,
              ),
              Text(key: key5, Strings.gcpDesc9095, style: style),
              const SizedBox(
                height: 16,
              ),
              Text(key: key6, Strings.gcpDesc95100, style: style),
            ],
          ),
        ),
        const SizedBox(
          width: 24,
        ),
        CustomPaint(
          painter: SliderPainter(
            value,
            height,
            () => getYPos(key1),
            () => getYPos(key2),
            () => getYPos(key3),
            () => getYPos(key4),
            () => getYPos(key5),
            () => getYPos(key6),
          ),
          child: const SizedBox(
            height: height,
            width: width,
          ),
        ),
      ],
    );
  }
}

typedef DoubleFunc = double Function(void);

class SliderPainter extends CustomPainter {
  final double value;
  final double height;
  late final paint1 = Paint()
    ..color = Colors.amber
    ..strokeCap = StrokeCap.round
    ..isAntiAlias = true
    ..strokeWidth = 20
    ..strokeJoin = StrokeJoin.round
    ..style = PaintingStyle.stroke
    ..shader = ui.Gradient.linear(
        const Offset(0.5, 0),
        Offset(0.5, height),
        [
          // const Color(0xff505050),
          // const Color(0xffFF0064),
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
        List.generate(12, (i) => 0.09 * i));
  late final paint2 = Paint()
    ..color = Colors.amber
    ..strokeCap = StrokeCap.round
    ..isAntiAlias = true
    ..strokeWidth = 2
    ..strokeJoin = StrokeJoin.round
    ..style = PaintingStyle.stroke
    ..shader = ui.Gradient.linear(
        const Offset(0.5, 0),
        Offset(0.5, height),
        [
          // const Color(0xff505050),
          // const Color(0xffFF0064),
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
        List.generate(12, (i) => threshold * i));
  late final paint3 = Paint()
    ..color = Colors.white
    ..strokeCap = StrokeCap.round
    ..isAntiAlias = true
    ..strokeWidth = 1
    ..strokeJoin = StrokeJoin.round
    ..style = PaintingStyle.stroke;
  double labelY1 = 0.0;
  double labelY2 = 0.0;
  double labelY3 = 0.0;
  double labelY4 = 0.0;
  double labelY5 = 0.0;
  double labelY6 = 0.0;

  SliderPainter(
    this.value,
    this.height,
    double Function() labelYPosFunc1,
    double Function() labelYPosFunc2,
    double Function() labelYPosFunc3,
    double Function() labelYPosFunc4,
    double Function() labelYPosFunc5,
    double Function() labelYPosFunc6,
  ) {
    labelY1 = labelYPosFunc1();
    labelY2 = labelYPosFunc2();
    labelY3 = labelYPosFunc3();
    labelY4 = labelYPosFunc4();
    labelY5 = labelYPosFunc5();
    labelY6 = labelYPosFunc6();
  }

  void _drawScale(Canvas canvas, Size size, double perc, double labelY) {
    final percValue = perc * size.height;
    final p1 = Offset(size.width / 2 - 12, percValue);
    final p2 = Offset(size.width / 2 + 12, percValue);
    var py1 = Offset(size.width / 2 - 12, percValue);
    var py2 = Offset(0, labelY);

    canvas.drawLine(p1, p2, paint3);
    canvas.drawLine(py1, py2, paint3);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Draw rainbow line
    var p1 = Offset(size.width / 2, 0);
    var p2 = Offset(size.width / 2, size.height);

    canvas.drawLine(p1, p2, paint1);

    // Draw scale
    _drawScale(canvas, size, 0.05, labelY1);
    _drawScale(canvas, size, 0.1, labelY2);
    _drawScale(canvas, size, 0.4, labelY3);
    _drawScale(canvas, size, 0.9, labelY4);
    _drawScale(canvas, size, 0.95, labelY5);
    _drawScale(canvas, size, 1.0, labelY6);

    // Draw pointer
    final yPos = value * size.height;
    final pp1 = Offset(size.width / 2 - 25, yPos - 5);
    final pp2 = Offset(size.width / 2 - 15, yPos);
    final pp3 = Offset(size.width / 2 - 25, yPos + 5);
    final pp4 = Offset(size.width / 2 - 15, yPos);

    canvas.drawLine(pp1, pp2, paint2);
    canvas.drawLine(pp3, pp4, paint2);
  }

  @override
  bool shouldRepaint(covariant SliderPainter oldDelegate) {
    return value != oldDelegate.value;
  }
}
