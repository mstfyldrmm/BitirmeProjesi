import 'package:qr_attendance_project/export.dart';

class StudentSingInView extends ChangeNotifier {
  ValueNotifier<String> studentMail = ValueNotifier<String>('');
  ValueNotifier<String> studentPassword = ValueNotifier<String>('');
  final ServiceLocalStorage serviceLocalStorage =
      locator<ServiceLocalStorage>();
  final _logger = Logger(printer: PrettyPrinter());

  Future<bool> loginStudent(
    GlobalKey<FormState> formKey,
    BuildContext context,
  ) async {
    if (formKey.currentState!.validate()) {
      final studentModel = await StudentAuthService().signInStudent(
        studentMail.value,
        studentPassword.value,
      );
      if (studentModel != null) {
        await serviceLocalStorage.setString(
          "studentEmail",
          studentMail.value,
        );
        await serviceLocalStorage.setString(
          "userType",
          "student",
        );
        _logger.i(
          'email saved shared ${serviceLocalStorage.getString('studentEmail')}',
        );
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  String? getStudentId() {
    return studentMail.value.split('@').first;
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
