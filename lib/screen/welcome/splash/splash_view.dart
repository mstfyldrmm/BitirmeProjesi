import 'package:geolocator/geolocator.dart';
import 'package:qr_attendance_project/export.dart';

class SplashView extends ChangeNotifier {
  final ServiceLocalStorage serviceLocalStorage =
      locator<ServiceLocalStorage>();
  final _logger = Logger(printer: PrettyPrinter());


  bool isLoggedInEmailPassword() {
    if (serviceLocalStorage.getString('userType') != null) {
      _logger.i(
        "Logged in user type: ${serviceLocalStorage.getString('userType')}",
      );
      return true;
    } else {
      _logger.i("There is no user logged in yet!");
      return false;
    }
  }

  bool getUserType() {
    String? userType = serviceLocalStorage.getString('userType');
    if (userType == "student") return true;
    return false;
  }

  String? getTeacherId() {
    String? teacherEmail = serviceLocalStorage.getString('teacherEmail');
    if (teacherEmail == null) return null;
    final String? teacherId = TeacherAuthService().getTeacherId();
    return teacherId;
  }

  String? getStudentId() {
    String? studentEmail = serviceLocalStorage.getString('studentEmail');
    if (studentEmail == null) return null;
    final studentId = studentEmail.split('@').first;
    return studentId;
  }

  Future<bool> checkLocationPermissions() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return false;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return false;
    }

    if (permission == LocationPermission.deniedForever) return false;

    return true;
  }
}
