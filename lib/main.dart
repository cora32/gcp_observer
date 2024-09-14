import 'package:flutter/material.dart';
import 'package:gcp_observer/repo/repo.dart';
import 'package:gcp_observer/repo/rest.dart';
import 'package:gcp_observer/strings.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'gcp_dot.dart';

// final getIt = GetIt.instance;

// We create a "provider", which will store a value (here "Hello world").
// By using a provider, this allows us to mock/override the value exposed.
// @riverpod
// String helloWorld(HelloWorldRef ref) {
//   return 'Hello world';
// }

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
        body: Center(
          child: ProviderScope(child: GCPDot()),
        ),
      ),
    );
  }
}
