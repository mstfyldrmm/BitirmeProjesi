import 'package:qr_attendance_project/export.dart';

class StudentDrawerView extends ChangeNotifier {
  ValueNotifier<List<ScreenHiddenDrawer>> pages = ValueNotifier([]);

  void pagesCreate(String userId) {
    pages.value = [
      screenHiddenDrawerWidget(
          title: LocaleKeys.studentMain_title.locale,
          widget: StudentMyLessonsScreen(
            userId: userId,
          )),
      screenHiddenDrawerWidget(
          title: LocaleKeys.studentTitle_request.locale,
          widget: StudentRequestScreen(
            userId: userId,
          )),
      screenHiddenDrawerWidget(
          title: LocaleKeys.account_title.locale,
          widget: StudentAccountScreen(
            studentModelId: userId,
          )),
    ];
  }
}
