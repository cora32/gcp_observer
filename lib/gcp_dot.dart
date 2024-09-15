import 'package:flutter/material.dart';
import 'package:gcp_observer/params.dart';
import 'package:gcp_observer/rainbow.dart';
import 'package:gcp_observer/repo/repo.dart';
import 'package:gcp_observer/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'chart.dart';

class GCPPanel extends ConsumerWidget {
  const GCPPanel({super.key});

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
    double width = MediaQuery.sizeOf(context).width - 16;
    // double height = MediaQuery.sizeOf(context).height;
    var padding = MediaQuery.paddingOf(context);
    // double newHeight = height - padding.top - padding.bottom;
    double chartHeight = 70;

    return Padding(
      padding:
          EdgeInsets.only(top: padding.top + 8, bottom: 8, left: 8, right: 8),
      child: Column(
        children: [
          // Dot
          GcpDot(data.dataA.last),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8.0),
            child: Description(data.dataA.last),
          ),
          // Expanded(child:),
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

class Description extends StatelessWidget {
  final double value;

  const Description(this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      getDescription(value),
      style: GoogleFonts.lato(
        textStyle: Theme.of(context).textTheme.displayLarge,
        fontSize: 15,
        color: Colors.white70,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
      ),
    ));
  }
}

class GcpDot extends StatefulWidget {
  final double value;

  const GcpDot(this.value, {super.key});

  @override
  State<GcpDot> createState() => _GcpDotState();
}

class _GcpDotState extends State<GcpDot> with SingleTickerProviderStateMixin {
  var value = 0.0;
  late final animationController =
      AnimationController(duration: const Duration(seconds: 5), vsync: this);
  late final Animation<double> anim =
      Tween(begin: 0.0, end: widget.value).animate(animationController);

  @override
  void initState() {
    super.initState();

    animationController
      ..addListener(() {
        setState(() {
          value = anim.value;
        });
      })
      ..forward();
  }

  @override
  void dispose() {
    super.dispose();

    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: CustomPaint(
          size: const Size(100, 100),
          painter: GCPPainter(value, 100),
        ));
  }
}

class GCPPainter extends CustomPainter {
  final double value;
  final double height;
  final paint1 = Paint()
    ..strokeCap = StrokeCap.round
    ..isAntiAlias = true
    ..strokeWidth = 10
    ..strokeJoin = StrokeJoin.round
    ..style = PaintingStyle.fill;
  static const colors = [
    Color(0xffFF1E1E),
    Color(0xffFFB82E),
    Color(0xffFFD517),
    Color(0xffFFFA40),
    Color(0xffF9FA00),
    Color(0xffAEFA00),
    Color(0xff64FA64),
    Color(0xff64FAAB),
    Color(0xffACF2FF),
    Color(0xff0EEEFF),
    Color(0xff24CBFD),
    Color(0xff5655CA),
  ];

  GCPPainter(
    this.value,
    this.height,
  ) {
    paint1.color =
        Rainbow(colors: colors, threshold: threshold).getColor(value);
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, paint1);
  }

  @override
  bool shouldRepaint(covariant GCPPainter oldDelegate) {
    return value != oldDelegate.value;
  }
}
