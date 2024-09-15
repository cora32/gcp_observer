import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/params.dart';

class Chart extends StatelessWidget {
  final List<double> data;
  final double width;
  final double height;
  final String label;

  const Chart(this.data, this.width, this.height, this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: labelWidth,
            child: Center(
              child: Text(
                label,
                style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.displayLarge,
                  fontSize: 20,
                  color: Colors.white70,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ),
          Expanded(
              child: CustomPaint(
            size: Size(width - labelWidth, height),
            painter: GCPChartPainter(data, width - labelWidth, height),
          ))
        ],
      ),
    );
  }
}

class GCPChartPainter extends CustomPainter {
  final double width;
  final double height;
  final List<double> data;
  final Path path = Path();
  double xStep = 0.0;

  final paint1 = Paint()
    ..color = Colors.amber
    ..strokeCap = StrokeCap.round
    ..isAntiAlias = true
    ..strokeWidth = 1
    ..strokeJoin = StrokeJoin.round
    ..style = PaintingStyle.stroke;
  final paint2 = Paint()
    ..color = Colors.amber
    ..strokeCap = StrokeCap.round
    ..isAntiAlias = true
    ..strokeWidth = 10
    ..strokeJoin = StrokeJoin.round
    ..style = PaintingStyle.fill;

  GCPChartPainter(this.data, this.width, this.height) {
    paint1.shader = ui.Gradient.linear(
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
        List.generate(12, (i) => 0.1 * i));
    paint2.shader = ui.Gradient.linear(
        const Offset(0.5, 0),
        Offset(0.5, height),
        [
          // const Color(0xff505050),
          // const Color(0xffFF0064),
          const Color(0xff840607),
          const Color(0xffC95E00),
          const Color(0xffC69000),
          const Color(0xffC6C300),
          const Color(0xffB0CC00),
          const Color(0xff88C200),
          const Color(0xff00A700),
          const Color(0xff00B5C9),
          const Color(0xff21BCF1),
          const Color(0xff0786E1),
          const Color(0xff0000FF),
          const Color(0xff2400A0),
        ],
        List.generate(12, (i) => 0.1 * i));

    path.reset();
    path.moveTo(0.0, 0.0);
    xStep = width / data.length;
    var x = 0.0;

    for (var item in data) {
      path.lineTo(x, item * height);
      x += xStep;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(path, paint1);
  }

  @override
  bool shouldRepaint(covariant GCPChartPainter oldDelegate) {
    return true;
  }
}
