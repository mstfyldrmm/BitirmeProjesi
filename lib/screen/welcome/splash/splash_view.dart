import 'package:qr_attendance_project/export.dart';

class SplashView extends ChangeNotifier {
  final ServiceLocalStorage serviceLocalStorage =
      locator<ServiceLocalStorage>();

  bool isLoggedInEmailPassword() {
    return serviceLocalStorage.getString('email') != null;
  }

  String? getUserIdStudent() {
    String? userEmail = serviceLocalStorage.getString('email');
    final userId = userEmail?.split('@').first;
    return userId;
  }

  String? getUserType() {
    return serviceLocalStorage.getString('type');
  }

  Future<String?> getUserIdTeacher() async {
    String? userEmail = serviceLocalStorage.getString('email');
    final userId = await TeacherAuthService().getUserIdByEmail(userEmail!);
    return userId;
  }
}
