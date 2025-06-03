import 'package:qr_attendance_project/export.dart';

class StudentsLessonDetailView extends ChangeNotifier {
  ValueNotifier<List<AttendanceModel?>> studentsAttendanceList =
      ValueNotifier([]);
  ValueNotifier<double?> studentsAttendanceCount = ValueNotifier(0.0);
  ValueNotifier<double?> lessonTotalAttendancesCount = ValueNotifier(0.0);
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
    final count = await AttendanceService().getStudentPastAttendancesCount(
        lessonId: lessonId, studentId: studentId);
    studentsAttendanceCount.value = count;

    final lessonModel = await TeacherService().fetchLessonInfo(lessonId);
    lessonTotalAttendancesCount.value =
        lessonModel?.totalAttendanceCount!.toDouble();
    studentAttendancePercent.value = (studentsAttendanceCount.value ?? 0.0) /
        (lessonTotalAttendancesCount.value ?? 1.0);
    return studentAttendancePercent.value ?? 0.0;
  }

  String extractTimestamp(String data) {
    List<String> parts = data.split('-');

    if (parts.isNotEmpty && parts.length >= 5) {
      return parts.sublist(1, 5).join('-');
    }

    return '';
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
