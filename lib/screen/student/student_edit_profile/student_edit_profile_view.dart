import 'package:qr_attendance_project/export.dart';

class StudentEditProfileView extends ChangeNotifier with NavigatorManager {
  ValueNotifier<String> studentName = ValueNotifier<String>('');
  ValueNotifier<String> studentSurname = ValueNotifier<String>('');
  ValueNotifier<String> studentPassword = ValueNotifier<String>('');

  Future<bool> updateStudentInfo(String studentId) async {
    try {
      await StudentAuthService().updateStudentInfo(
          studentId, studentName.value, studentSurname.value);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> sendPasswordResetLink(String email, BuildContext context) async {
    bool isOkey = await StudentAuthService().sendPasswordResetLink(email);

    if (isOkey) {
      showCustomSnackBar(
        context,
        LocaleKeys.passwordReset_successMessage.locale,
        false,
      );
      serviceLocalStorage.logout();
      navigateToNoBackWidget(context, StartScreen());
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
}

//notifier bak
//
