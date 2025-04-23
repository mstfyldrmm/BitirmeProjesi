import 'package:qr_attendance_project/export.dart';

ScreenHiddenDrawer screenHiddenDrawerWidget(
    {required String title, required Widget widget}) {
  return ScreenHiddenDrawer(
      ItemHiddenMenu(
        name: title,
        baseStyle: textStyleUnselected(),
        selectedStyle: textStyle(),
      ),
      widget);
}

TextStyle textStyle() => TextStyle(
    fontWeight: FontWeight.w800, fontSize: 20, );
TextStyle textStyleUnselected() =>
    TextStyle(fontWeight: FontWeight.w600, fontSize: 14);
