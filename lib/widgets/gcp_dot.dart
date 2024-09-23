import 'package:flutter/material.dart';
import 'package:gcp_observer/utils/params.dart';
import 'package:gcp_observer/utils/rainbow.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/utils.dart';


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
        fontStyle: FontStyle.normal,
      ),
    ));
  }
}

class GcpDot extends StatefulWidget {
  final double value;
  final double size;

  const GcpDot(this.value, this.size, {super.key});

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
    return RepaintBoundary(
        child: CustomPaint(
      size: Size(widget.size, widget.size),
      painter: GCPPainter(value, widget.size, widget.size),
    ));
  }
}

class GCPPainter extends CustomPainter {
  final double value;
  final double width;
  final double height;
  final paint1 = Paint()
    ..strokeCap = StrokeCap.round
    ..isAntiAlias = true
    ..strokeWidth = 10
    ..strokeJoin = StrokeJoin.round
    ..style = PaintingStyle.fill;
  final paintC = Paint()
    ..strokeCap = StrokeCap.round
    ..isAntiAlias = true
    ..strokeWidth = 3
    ..strokeJoin = StrokeJoin.round
    ..color = Colors.black87
    ..style = PaintingStyle.stroke;
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
  final style = GoogleFonts.lato(
    fontSize: 17,
    color: Colors.black87,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
  );
  final style2 = GoogleFonts.lato(
    fontSize: 17.1,
    color: Colors.white54,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
  );
  late final TextPainter textPainter;
  late final TextPainter textPainter2;
  var xCenter = 0.0;
  var yCenter = 0.0;
  var xCenter2 = 0.0;
  var yCenter2 = 0.0;

  GCPPainter(
    this.value,
    this.width,
    this.height,
  ) {
    paint1.color =
        Rainbow(colors: colors, threshold: threshold).getColor(value);
    final text = '${(value * 100).toInt()}%';
    final textSpan = TextSpan(text: text, style: style);
    final textSpan2 = TextSpan(text: text, style: style2);
    textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: 50);
    textPainter2 =
        TextPainter(text: textSpan2, textDirection: TextDirection.ltr)
          ..layout(minWidth: 0, maxWidth: 50);
    xCenter = (width - textPainter.width) / 2;
    yCenter = (height - textPainter.height) / 2 - 1;
    xCenter2 = (width - textPainter2.width) / 2;
    yCenter2 = (height - textPainter2.height) / 2;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Draw circle
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, paint1);

    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, paintC);

    // Draw text
    final offset = Offset(xCenter, yCenter);
    final offset2 = Offset(xCenter2, yCenter2);
    textPainter2.paint(canvas, offset2);
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant GCPPainter oldDelegate) {
    return value != oldDelegate.value;
  }
}
