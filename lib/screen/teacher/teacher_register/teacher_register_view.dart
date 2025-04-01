import 'package:qr_attendance_project/export.dart';

class TeacherRegisterView with ChangeNotifier {
  ValueNotifier<String> teacherName = ValueNotifier<String>('');
  ValueNotifier<String> teacherSurname = ValueNotifier<String>('');
  ValueNotifier<String> teacherMail = ValueNotifier<String>('');
  ValueNotifier<String> teacherPassword = ValueNotifier<String>('');

  Future<bool> registerTeacher() async {
    TeacherModel? teacherModel = await TeacherAuthService().signUpTeacher(
        teacherMail.value,
        teacherPassword.value,
        TeacherModel(
            teacherMailAdress: teacherMail.value,
            teacherName: teacherName.value,
            teacherSurname: teacherSurname.value));
    if (teacherModel != null) return true;
    return false;
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

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validate_passwordRequired.locale;
    }

    if (value.length < 6) {
      return LocaleKeys.validate_password.locale;
    }
    return null;
  }

  String? validateTextField(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validate_noEmpty.locale;
    }
    return null;
  }
}
