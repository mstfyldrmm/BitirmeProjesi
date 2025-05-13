import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:qr_attendance_project/model/base_model.dart';

class AttendanceModel extends BaseModel<AttendanceModel> with EquatableMixin {
  String? studentId;
  String? studentName;
  String? studentSurname;
  int? schoolNumber;
  String? qrAttendanceId;
  String? attendanceLessonId;
  String? qrCodeData;
  String? qrCodeLocation;
  int? qrAttendanceClass;
  Timestamp? createdDate;

  AttendanceModel({
    this.studentId,
    this.studentName,
    this.studentSurname,
    this.schoolNumber,
    this.qrAttendanceId,
    this.attendanceLessonId,
    this.qrCodeData,
    this.qrCodeLocation,
    this.qrAttendanceClass,
    this.createdDate,
  });

  @override
  List<Object?> get props => [
        studentId,
        studentName,
        studentSurname,
        schoolNumber,
        qrAttendanceId,
        attendanceLessonId,
        qrCodeData,
        qrCodeLocation,
        qrAttendanceClass,
        createdDate
      ];

  AttendanceModel copyWith({
    String? studentId,
    String? studentName,
    String? studentSurname,
    int? schoolNumber,
    String? qrAttendanceId,
    String? attendanceLessonId,
    String? qrCodeData,
    String? qrCodeLocation,
    int? qrAttendanceClass,
    Timestamp? createdDate,
  }) {
    return AttendanceModel(
      studentId: studentId ?? studentId,
      studentName: studentName ?? studentName,
      studentSurname: studentSurname ?? studentSurname,
      schoolNumber: schoolNumber ?? schoolNumber,
      qrAttendanceId: qrAttendanceId ?? qrAttendanceId,
      attendanceLessonId: attendanceLessonId ?? attendanceLessonId,
      qrCodeData: qrCodeData ?? qrCodeData,
      qrCodeLocation: qrCodeLocation ?? qrCodeLocation,
      qrAttendanceClass: qrAttendanceClass ?? qrAttendanceClass,
      createdDate: createdDate ?? createdDate,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'studentName': studentName,
      'studentSurname': studentSurname,
      'schoolNumber': schoolNumber,
      'qrAttendanceId': qrAttendanceId,
      'attendanceLessonId': attendanceLessonId,
      'qrCodeData': qrCodeData,
      'qrCodeLocation': qrCodeLocation,
      'qrAttendanceClass': qrAttendanceClass,
      'created_date': createdDate,
    };
  }

  @override
  AttendanceModel fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      studentId: json['studentId'] as String?,
      studentName: json['studentName'] as String?,
      studentSurname: json['studentSurname'] as String?,
      schoolNumber: json['schoolNumber'] as int?,
      qrAttendanceId: json['qrAttendanceId'] as String?,
      attendanceLessonId: json['attendanceLessonId'] as String?,
      qrCodeData: json['qrCodeData'] as String?,
      qrCodeLocation: json['qrCodeLocation'] as String?,
      qrAttendanceClass: json['qrAttendanceClass'] as int?,
      createdDate: json['created_date'] as Timestamp?,
    );
  }
}
