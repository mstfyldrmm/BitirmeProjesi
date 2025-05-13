import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:qr_attendance_project/services/locator.dart';
import 'package:qr_attendance_project/services/service_local_storage.dart';

mixin NavigatorManager {
  final ServiceLocalStorage serviceLocalStorage =
      locator<ServiceLocalStorage>();
  final logger = Logger(printer: PrettyPrinter());

  void navigateToWidget(BuildContext context, Widget widget) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return widget;
        },
        fullscreenDialog: true,
        settings: RouteSettings()));
  }

  void navigateToNoBackWidget(BuildContext context, Widget widget) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false, // Bu, önceki tüm sayfaları kaldırır
    );
  }

  Future<T?> navigateToNormalWidget<T>(BuildContext context, Widget widget) {
    return Navigator.of(context).push<T>(MaterialPageRoute(
        builder: (context) {
          return widget;
        },
        fullscreenDialog: true,
        settings: RouteSettings()));
  }

  void customShowBottomSheet({
    required BuildContext context,
    required Widget child,
  }) {
    showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      useSafeArea: true,
      enableDrag: false,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (context) {
        return child;
      },
    );
  }
}
