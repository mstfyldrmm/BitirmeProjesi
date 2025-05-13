import 'package:qr_attendance_project/model/attendance_model.dart';

class AttendanceGroupModel {
  final String date;
  final List<AttendanceModel?> attendances;

  AttendanceGroupModel({required this.date, required this.attendances});
}
