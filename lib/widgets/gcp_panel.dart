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

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: padding.top + 24, bottom: 8),
        child: Column(
          children: [
            // Title
            const GCPTitle(),
            // Dot
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
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
                children: [
                  // GCPDot
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 5,
                        child: Description(data.dataA.last),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Flexible(
                        flex: 2,
                        child: GcpDot(data.dataA.last, 80),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  // Slider
                  const Align(
                    alignment: Alignment.centerRight,
                    child: GCPSlider(),
                  ),
                ],
              ),
            ),
            // Chart
            Chart(data.dataA, width, chartHeight, Strings.labelA),
            Chart(data.dataB, width, chartHeight, Strings.labelB),
            Chart(data.dataQ1, width, chartHeight, Strings.labelQ1),
            Chart(data.dataQ3, width, chartHeight, Strings.labelQ3),
            Chart(data.dataT, width, chartHeight, Strings.labelT),
          ],
        ),
      ),
    );
  }
}
