import 'package:qr_attendance_project/export.dart';

class TeacherDrawerView with ChangeNotifier {
  ValueNotifier<List<ScreenHiddenDrawer>> pages = ValueNotifier([]);

  void pagesCreate(String userId) {
    pages.value = [
      screenHiddenDrawerWidget(
          title: LocaleKeys.studentMain_title.locale,
          widget: TeacherMyLessons(
            teacherId: userId,
          )),
      screenHiddenDrawerWidget(
          title: 'Öğrenci Talepleri', widget: SizedBox.shrink()),
      screenHiddenDrawerWidget(
          title: LocaleKeys.studentAccount_title.locale,
          widget: TeacherAccountScreen(
            teacherModelId: userId,
          )),
    ];
  }
}
