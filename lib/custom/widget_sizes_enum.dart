enum WidgetSizes { smallPadding, normalPadding, bigPadding }

extension WidgetSizeExtension on WidgetSizes {
  double get value {
    switch (this) {
      case WidgetSizes.smallPadding:
        // TODO: Handle this case.
        return 10;
      case WidgetSizes.normalPadding:
        // TODO: Handle this case.
        return 20;
      case WidgetSizes.bigPadding:
        // TODO: Handle this case.
        return 30;
    }
  }
}
