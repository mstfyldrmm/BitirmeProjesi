import 'package:qr_attendance_project/export.dart';

class StudentAccountView extends ChangeNotifier {
  ValueNotifier<StudentModel?> studentModel =
      ValueNotifier<StudentModel?>(null);

  ValueNotifier<bool> isDarkMode = ValueNotifier(false);
  ValueNotifier<String> deviceLanguage =
      ValueNotifier(PlatformDispatcher.instance.locale.languageCode);

  Future<void> getStudentInfo(String studentId) async {
    studentModel.value = await StudentService().fetchStudent(studentId);
  }

  Future<bool> logOutStudent() async {
    return await StudentAuthService().logOutStudent();
  }

  void onThemeChanged() {
    isDarkMode.value = !isDarkMode.value;
  }
}
