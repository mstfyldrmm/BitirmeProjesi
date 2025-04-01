import 'package:qr_attendance_project/export.dart';


class TeacherLoginView with ChangeNotifier, NavigatorManager {
  ValueNotifier<String> teacherMail = ValueNotifier<String>('');
  ValueNotifier<String> teacherPassword = ValueNotifier<String>('');

  Future<void> loginTeacher(
      GlobalKey<FormState> _formKey, BuildContext context) async {
    // Login işlemi
    if (_formKey.currentState!.validate()) {
      try {
        final teacherModel = await TeacherAuthService()
            .signInTeacher(teacherMail.value, teacherPassword.value);
        if (teacherModel != null) {
          await serviceLocalStorage.saveUserData(
              key: 'email', value: teacherMail.value, type: 'teacher');
          logger.i(
              'email saved shared ${serviceLocalStorage.getString('email')} userType: ${serviceLocalStorage.getUserType()}');
          navigateToNoBackWidget(
              context,
              TeacherDrawerContent(
                userId: teacherModel.teacherId,
              ));
        }
      } catch (e) {}
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

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validate_passwordRequired.locale;
    }

    if (value.length < 6) {
      return LocaleKeys.validate_password.locale;
    }
    return null;
  }
}
