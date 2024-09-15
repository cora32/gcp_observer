import 'package:gcp_observer/params.dart';
import 'package:gcp_observer/strings.dart';

String latestDesc = '';

String getDescription(double value) => latestDesc = switch (value) {
      >= 0 * threshold && <= 2 * threshold => Strings.gcpDesc02,
      >= 2 * threshold && <= 4 * threshold => Strings.gcpDesc24,
      >= 4 * threshold && <= 6 * threshold => Strings.gcpDesc46,
      >= 6 * threshold && <= 8 * threshold => Strings.gcpDesc68,
      >= 8 * threshold && <= 10 * threshold => Strings.gcpDesc810,
      >= 10 * threshold && <= 12 * threshold => Strings.gcpDesc1012,
      double() => latestDesc,
    };
