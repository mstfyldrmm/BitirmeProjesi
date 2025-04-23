import 'package:qr_attendance_project/export.dart';
import 'package:qr_attendance_project/screen/teacher/teacher_request/teacher_request_screen.dart';

class TeacherDrawerView extends ChangeNotifier {
  ValueNotifier<List<ScreenHiddenDrawer>> pages = ValueNotifier([]);

  void pagesCreate(String userId) {
    pages.value = [
      screenHiddenDrawerWidget(
          title: LocaleKeys.studentMain_title.locale,
          widget: TeacherMyLessons(
            teacherId: userId,
          )),
      screenHiddenDrawerWidget(
          title: LocaleKeys.teacherTitle_studentRequests.locale,
          widget: TeacherRequestScreen(
            teacherId: userId,
          )),
      screenHiddenDrawerWidget(
          title: LocaleKeys.account_title.locale,
          widget: TeacherAccountScreen(
            teacherModelId: userId,
          )),
    ];
  }
}
