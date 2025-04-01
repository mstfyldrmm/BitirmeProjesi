import 'package:qr_attendance_project/export.dart';

class StudentSingInView extends ChangeNotifier with NavigatorManager {
  ValueNotifier<String> studentMail = ValueNotifier<String>('');
  ValueNotifier<String> studentPassword = ValueNotifier<String>('');

  Future<void> loginStudent(
      GlobalKey<FormState> _formKey, BuildContext context) async {
    // Login işlemi
    if (_formKey.currentState!.validate()) {
      try {
        final studentModel = await StudentAuthService()
            .signInStudent(studentMail.value, studentPassword.value);
        if (studentModel != null) {
          await serviceLocalStorage.saveUserData(
              key: 'email', value: studentMail.value, type: 'student');
          logger.i(
              'email saved shared ${serviceLocalStorage.getString('email')} userType: ${serviceLocalStorage.getUserType()}');
          navigateToNoBackWidget(
            context,
            StudentDrawerContent(
              userId: studentMail.value.split('@').first,
            ),
          );
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
