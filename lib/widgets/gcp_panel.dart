import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../repo/repo.dart';
import '../utils/strings.dart';
import 'chart.dart';
import 'gcp_dot.dart';
import 'gcp_slider.dart';
import 'gcp_title.dart';

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

class ContentScreen extends StatefulWidget {
  final GCPData data;

  const ContentScreen(this.data, {super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width - 16;
    // double height = MediaQuery.sizeOf(context).height;
    var padding = MediaQuery.paddingOf(context);
    // double newHeight = height - padding.top - padding.bottom;
    double chartHeight = 70;

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.only(top: padding.top + 24, bottom: 8),
        child: Column(
          children: [
            // Title
            const GCPTitle(),
            // Dot
            ExpandableDot(widget.data),
            // Chart
            Chart(widget.data.dataA, width, chartHeight, Strings.labelA),
            Chart(widget.data.dataB, width, chartHeight, Strings.labelB),
            Chart(widget.data.dataQ1, width, chartHeight, Strings.labelQ1),
            Chart(widget.data.dataQ3, width, chartHeight, Strings.labelQ3),
            Chart(widget.data.dataT, width, chartHeight, Strings.labelT),
          ],
        ),
      ),
    );
  }
}

class ExpandableDot extends StatefulWidget {
  final GCPData data;

  const ExpandableDot(this.data, {super.key});

  @override
  State<ExpandableDot> createState() => _ExpandableDotState();
}

class _ExpandableDotState extends State<ExpandableDot> {
  var _isDetailsShown = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isDetailsShown = !_isDetailsShown;
        });
      },
      child: Container(
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
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // GCPDot
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 5,
                    child: Description(widget.data.dataA.last),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    flex: 2,
                    child: GcpDot(widget.data.dataA.last, 80),
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              // Slider
              AnimatedSize(
                curve: Curves.easeIn,
                duration: const Duration(milliseconds: 800),
                child: _isDetailsShown
                    ? const Align(
                        alignment: Alignment.centerRight, child: GCPSlider())
                    : const ArrowDown(),
              ),
            ]),
      ),
    );
  }
}

class ArrowDown extends StatelessWidget {
  const ArrowDown({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.keyboard_arrow_down_rounded,
      color: Colors.white54,
    );
  }
}
