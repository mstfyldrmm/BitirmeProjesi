import 'package:geolocator/geolocator.dart';
import 'package:qr_attendance_project/export.dart';

class StudentsLessonDetailView extends ChangeNotifier {
  ValueNotifier<List<AttendanceModel?>> studentsAttendanceList =
      ValueNotifier([]);
  ValueNotifier<Position?> currentLocation = ValueNotifier(null);

  ValueNotifier<double?> studentAttendancePercent = ValueNotifier(0.0);

  Future<List<AttendanceModel?>> fetchStudentsAttendanceList(
      {required String lessonId, required String studentId}) async {
    final data = await AttendanceService()
        .getStudentPastAttendances(lessonId: lessonId, studentId: studentId);

    studentsAttendanceList.value = data;
    return studentsAttendanceList.value;
  }

  Future<double> fetchStudentsAttendanceState(
      {required String lessonId, required String studentId}) async {
    final count = await AttendanceService().getStudentLessonAttendanceValue(
        lessonId: lessonId, studentId: studentId);
    if (count != null && count > 1) {
      studentAttendancePercent.value = 1;
      return studentAttendancePercent.value ?? 0;
    }
    studentAttendancePercent.value = count;
    return studentAttendancePercent.value ?? 0;
  }

  String extractTimestamp(String data) {
    List<String> parts = data.split('-');

    if (parts.isNotEmpty && parts.length >= 5) {
      return parts.sublist(1, 5).join('-');
    }

    return '';
  }

  Future<Position?> getCurrentPosition() async {
    try {
      Position? position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 0,
        ),
      );
      currentLocation.value = position;
      return currentLocation.value;
    } catch (e) {
      debugPrint('Konum alınamadı: $e');
      return null;
    }
  }

  String convertTime(String data) {
    // Noktaya göre ayır, sadece ilk kısmı kullan
    List<String> parts = data.split('.');

    if (parts.isNotEmpty && parts.length >= 2) {
      DateTime dateTime = DateTime.parse(parts[0]);
      String day = dateTime.day.toString().padLeft(2, '0');
      String month = dateTime.month.toString().padLeft(2, '0');
      String year = dateTime.year.toString();
      String hour = dateTime.hour.toString().padLeft(2, '0');
      String minute = dateTime.minute.toString().padLeft(2, '0');
      String second = dateTime.second.toString().padLeft(2, '0');

      return '$day-$month-$year $hour:$minute:$second';
    }
    return '';
  }
}
