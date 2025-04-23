import 'package:qr_attendance_project/export.dart';

class TeacherLoginView extends ChangeNotifier with NavigatorManager {
  ValueNotifier<String> teacherMail = ValueNotifier<String>('');
  ValueNotifier<String> teacherPassword = ValueNotifier<String>('');
  final _logger = Logger(printer: PrettyPrinter());

  Future<bool> loginTeacher(
    GlobalKey<FormState> formKey,
    BuildContext context,
  ) async {
    if (formKey.currentState!.validate()) {
      final teacherModel = await TeacherAuthService().signInTeacher(
        teacherMail.value,
        teacherPassword.value,
      );
      if (teacherModel != null) {
        await serviceLocalStorage.setString(
          "teacherEmail",
          teacherMail.value,
        );
        await serviceLocalStorage.setString(
          "userType",
          "teacher",
        );
        _logger.i(
          'email saved shared ${serviceLocalStorage.getString('teacherEmail')}',
        );
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  String? getTeacherId() {
    return TeacherAuthService().getTeacherId();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validate_mail.locale;
    }

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
