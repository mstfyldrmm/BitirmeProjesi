import 'package:flutter/material.dart';

enum WidgetSizes { smallPadding, normalPadding, bigPadding }

extension WidgetSizeExtension on WidgetSizes {
  EdgeInsets get value {
    switch (this) {
      case WidgetSizes.smallPadding:
        // TODO: Handle this case.
        return EdgeInsets.all(10);
      case WidgetSizes.normalPadding:
        // TODO: Handle this case.
        return EdgeInsets.all(20);
      case WidgetSizes.bigPadding:
        // TODO: Handle this case.
        return EdgeInsets.all(30);
    }
  }
}
