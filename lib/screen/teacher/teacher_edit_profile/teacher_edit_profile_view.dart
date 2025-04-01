import 'package:qr_attendance_project/export.dart';

class TeacherEditProfileView extends ChangeNotifier with NavigatorManager {
  ValueNotifier<String> teacherName = ValueNotifier<String>('');
  ValueNotifier<String> teacherSurname = ValueNotifier<String>('');
  ValueNotifier<String> teacherPassword = ValueNotifier<String>('');

  Future<bool> updateTeacherInfo(String teacherId) async {
    try {
      await TeacherAuthService().updateTeacherInfo(
          teacherId, teacherName.value, teacherSurname.value);
      return true;
    } catch (e) {
      return false;
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validate_mail.locale;
    }

    // Belirtilen uzantı için regex deseni
    final RegExp emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@stu\.omu\.edu\.tr$");

    if (!emailRegex.hasMatch(value)) {
      return LocaleKeys.validate_mailRequired.locale;
    }
    return null;
  }

  String? validateTextField(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validate_noEmpty.locale;
    }
    return null;
  }

  void updateCheckMethod(GlobalKey<FormState> _formKey, BuildContext context,
      String teacherId) async {
    if (_formKey.currentState!.validate()) {
      await updateTeacherInfo(teacherId);
      navigateToNoBackWidget(
          context,
          StudentAccountScreen(
            studentModelId: teacherId,
          ));
    }
  }
}



//notifier bak
//