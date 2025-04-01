import 'package:qr_attendance_project/export.dart';

class StudentPasswordManagementView extends ChangeNotifier
    with NavigatorManager {
  ValueNotifier<String> mailAdress = ValueNotifier<String>('');

  Future<void> sendEmailLink(
      GlobalKey<FormState> _formKey, BuildContext context) async {
    // Login işlemi
    if (_formKey.currentState!.validate()) {
      bool isOkey =
          await StudentAuthService().sendPasswordResetLink(mailAdress.value);

      if (isOkey) {
        showCustomSnackBar(
            context, LocaleKeys.passwordReset_successMessage.locale, false);
        serviceLocalStorage.clearAll();
        navigateToNoBackWidget(context, StartScreen());
      }
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
}
