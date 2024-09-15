import 'package:flutter/widgets.dart';
import 'package:gcp_observer/utils/strings.dart';

String getDescription(double value) => switch (value) {
      >= 0.0 && < .05 => Strings.gcpDesc05,
      >= .05 && < .10 => Strings.gcpDesc510,
      >= .10 && < .40 => Strings.gcpDesc1040,
      >= .40 && < .90 => Strings.gcpDesc4090,
      >= .90 && < .95 => Strings.gcpDesc9095,
      >= .95 => Strings.gcpDesc95100,
      double() => Strings.gcpDesc95100,
    };

double getYPos(GlobalKey key) {
  if (key.currentContext != null) {
    RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero);
    return position.dy;
  } else {
    return 0.0;
  }
}
