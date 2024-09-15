import 'package:flutter/material.dart';
import 'package:gcp_observer/repo/repo.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utils/strings.dart';
import 'gcp_panel.dart';

class GCPTitle extends ConsumerStatefulWidget {
  const GCPTitle({super.key});

  @override
  ConsumerState<GCPTitle> createState() => _GCPTitleState();
}

class _GCPTitleState extends ConsumerState<GCPTitle> {
  @override
  Widget build(BuildContext context) {
    final result = ref.watch(getParsedGcpDataProvider);

    return switch (result) {
      AsyncData(:final value) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
          child: AnimatedText(value.dataA.last,
              style: GoogleFonts.lato(
                textStyle: Theme.of(context).textTheme.displayLarge,
                fontSize: 32,
                color: Colors.white70,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              )),
        ),
      AsyncError(:final error) => Text(error.toString()),
      _ => const LoadingScreen()
    };
  }
}

class AnimatedText extends StatefulWidget {
  final double value;
  final TextStyle style;

  const AnimatedText(this.value, {super.key, required this.style});

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin {
  late final end = (widget.value * 100).toInt();
  late final controller =
      AnimationController(duration: const Duration(seconds: 5), vsync: this);
  late final anim = IntTween(begin: prevValue, end: end).animate(controller);
  var value = 0;
  var prevValue = 0;

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
    return Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
              0.0,
              0.3,
              0.7,
              1.0
            ],
                colors: [
              Colors.transparent,
              Colors.black26,
              Colors.black26,
              Colors.transparent,
            ])),
        child: Center(
            child: Text('${Strings.gcpTitle}$value%', style: widget.style)));
  }
}
