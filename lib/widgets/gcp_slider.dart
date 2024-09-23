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
  GlobalKey keyUpper = GlobalKey();
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
      key: keyUpper,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(key: key1, Strings.gcpDesc05, style: style),
              const DelimWhite(),
              Text(key: key2, Strings.gcpDesc510, style: style),
              const DelimWhite(),
              Text(key: key3, Strings.gcpDesc1040, style: style),
              const DelimWhite(),
              Text(key: key4, Strings.gcpDesc4090, style: style),
              const DelimWhite(),
              Text(key: key5, Strings.gcpDesc9095, style: style),
              const DelimWhite(),
              Text(key: key6, Strings.gcpDesc95100, style: style),
            ],
          ),
        ),
        RepaintBoundary(
          child: CustomPaint(
            painter: SliderPainter(
              value,
              height,
              () => -getYPos(keyUpper),
              () => getHeight(key1),
              () => getHeight(key2),
              () => getHeight(key3),
              () => getHeight(key4),
              () => getHeight(key5),
              () => getHeight(key6),
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
    ..color = Colors.white54
    ..strokeCap = StrokeCap.round
    ..isAntiAlias = true
    ..strokeWidth = 0.6
    ..strokeJoin = StrokeJoin.round
    ..style = PaintingStyle.stroke;
  double labelY1 = 0.0;
  double labelY2 = 0.0;
  double labelY3 = 0.0;
  double labelY4 = 0.0;
  double labelY5 = 0.0;
  double labelY6 = 0.0;
  double labelHeight1 = 0.0;
  double labelHeight2 = 0.0;
  double labelHeight3 = 0.0;
  double labelHeight4 = 0.0;
  double labelHeight5 = 0.0;
  double labelHeight6 = 0.0;
  double topYOffset = 0.0;
  final double Function() topYOffsetFunc;
  final double Function() labelYPosFunc1;
  final double Function() labelYPosFunc2;
  final double Function() labelYPosFunc3;
  final double Function() labelYPosFunc4;
  final double Function() labelYPosFunc5;
  final double Function() labelYPosFunc6;
  final double Function() labelHeightFunc1;
  final double Function() labelHeightFunc2;
  final double Function() labelHeightFunc3;
  final double Function() labelHeightFunc4;
  final double Function() labelHeightFunc5;
  final double Function() labelHeightFunc6;

  SliderPainter(
    this.value,
    this.height,
    this.topYOffsetFunc,
    this.labelHeightFunc1,
    this.labelHeightFunc2,
    this.labelHeightFunc3,
    this.labelHeightFunc4,
    this.labelHeightFunc5,
    this.labelHeightFunc6,
    this.labelYPosFunc1,
    this.labelYPosFunc2,
    this.labelYPosFunc3,
    this.labelYPosFunc4,
    this.labelYPosFunc5,
    this.labelYPosFunc6,
  ) {
    topYOffset = topYOffsetFunc();
    labelY1 = labelYPosFunc1();
    labelY2 = labelYPosFunc2();
    labelY3 = labelYPosFunc3();
    labelY4 = labelYPosFunc4();
    labelY5 = labelYPosFunc5();
    labelY6 = labelYPosFunc6();
    labelHeight1 = labelHeightFunc1();
    labelHeight2 = labelHeightFunc2();
    labelHeight3 = labelHeightFunc3();
    labelHeight4 = labelHeightFunc4();
    labelHeight5 = labelHeightFunc5();
    labelHeight6 = labelHeightFunc6();
  }

  void _drawScale(
      Canvas canvas, Size size, double perc, double labelY, double height) {
    final percValue = perc * size.height;
    final p1 = Offset(size.width / 2 - 12, percValue);
    final p2 = Offset(size.width / 2 + 12, percValue);
    final py1 = Offset(size.width / 2 - 12, percValue);
    final py2 = Offset(0, labelY + topYOffset + height / 2.0);
    final ph1 = Offset(0, labelY + topYOffset);
    final ph2 = Offset(0, labelY + topYOffset + height);

    canvas.drawLine(p1, p2, paint3);
    canvas.drawLine(py1, py2, paint3);
    canvas.drawLine(ph1, ph2, paint3);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Draw rainbow line
    var p1 = Offset(size.width / 2, 0);
    var p2 = Offset(size.width / 2, size.height);

    canvas.drawLine(p1, p2, paint1);

    // Draw scale
    if (labelY1 >= 0) {
      _drawScale(canvas, size, 0.05, labelY1, labelHeight1);
      _drawScale(canvas, size, 0.1, labelY2, labelHeight2);
      _drawScale(canvas, size, 0.4, labelY3, labelHeight3);
      _drawScale(canvas, size, 0.9, labelY4, labelHeight4);
      _drawScale(canvas, size, 0.95, labelY5, labelHeight5);
      _drawScale(canvas, size, 1.0, labelY6, labelHeight6);
    }

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

class DelimWhite extends StatelessWidget {
  const DelimWhite({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [
            0.0,
            0.3,
            0.7,
            1.0
          ],
              colors: [
            Colors.white12,
            Colors.white10,
            Colors.transparent,
            Colors.transparent,
          ])),
      height: 8,
    );
  }
}
