import 'package:qr_attendance_project/export.dart';


class StudentDrawerView with ChangeNotifier {
  ValueNotifier<List<ScreenHiddenDrawer>> pages = ValueNotifier([]);

  void pagesCreate(String userId) {
    pages.value = [
      screenHiddenDrawerWidget(
          title: LocaleKeys.studentMain_title.locale,
          widget: StudentMyLessonsScreen(
            userId: userId,
          )),
      screenHiddenDrawerWidget(title: 'Taleplerim', widget: SizedBox.shrink()),
      screenHiddenDrawerWidget(
          title: LocaleKeys.studentAccount_title.locale,
          widget: StudentAccountScreen(
            studentModelId: userId,
          )),
    ];
  }
}
