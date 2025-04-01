import 'package:qr_attendance_project/export.dart';

class StudentRegisterView extends ChangeNotifier {
  ValueNotifier<String> studentName = ValueNotifier<String>('');
  ValueNotifier<String> studentSurname = ValueNotifier<String>('');
  ValueNotifier<String> studentMail = ValueNotifier<String>('');
  ValueNotifier<String> studentPassword = ValueNotifier<String>('');

  Future<bool> registerStudent() async {
    StudentModel? studentModel = await StudentAuthService().signUpStudent(
      studentMail.value,
      studentPassword.value,
      StudentModel(
        studentName: studentName.value,
        studentSurname: studentSurname.value,
        mailAddress: studentMail.value,
      ),
    );

    if (studentModel != null) return true;
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



//notifier bak
//