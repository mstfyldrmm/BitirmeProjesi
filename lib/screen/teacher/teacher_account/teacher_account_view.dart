import 'package:qr_attendance_project/export.dart';


class TeacherAccountView extends ChangeNotifier {
  ValueNotifier<TeacherModel?> teacherModel =
      ValueNotifier<TeacherModel?>(null);

  ValueNotifier<bool> isDarkMode = ValueNotifier(false);
  ValueNotifier<String> deviceLanguage =
      ValueNotifier(PlatformDispatcher.instance.locale.languageCode);

  Future<void> getTeacherInfo(String teacherId) async {
    teacherModel.value = await TeacherService().fetchTeacher(teacherId);
  }

  Future<bool> logOutStudent() async {
    return await TeacherAuthService().logOutTeacher();
  }

  void onThemeChanged() {
    isDarkMode.value = !isDarkMode.value;
  }
}
