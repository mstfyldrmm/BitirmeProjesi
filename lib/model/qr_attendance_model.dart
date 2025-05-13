import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:qr_attendance_project/model/base_model.dart';

class QrAttendanceModel extends BaseModel<QrAttendanceModel>
    with EquatableMixin {
  String? qrAttendanceId;
  String? attendanceLessonId;
  String? qrCodeData;
  String? qrCodeLocation;
  int? qrCodeTimeLimit;
  String? qrCodeTimeLimitType;
  int? qrAttendanceClass;
  Timestamp? createdDate;

  QrAttendanceModel({
    this.qrAttendanceId,
    this.attendanceLessonId,
    this.qrCodeData,
    this.qrCodeLocation,
    this.qrCodeTimeLimit,
    this.qrCodeTimeLimitType,
    this.qrAttendanceClass,
    this.createdDate,
  });

  @override
  List<Object?> get props => [
        qrAttendanceId,
    attendanceLessonId,
        qrCodeData,
        qrCodeLocation,
        qrCodeTimeLimit,
        qrCodeTimeLimitType,
        qrAttendanceClass,
        createdDate
      ];

  QrAttendanceModel copyWith({
    String? qrAttendanceId,
    String? attendanceLessonId,
    String? qrCodeData,
    String? qrCodeLocation,
    int? qrCodeTimeLimit,
    String? qrCodeTimeLimitType,
    int? qrAttendanceClass,
    Timestamp? createdDate,
  }) {
    return QrAttendanceModel(
      qrAttendanceId: qrAttendanceId ?? this.qrAttendanceId,
      attendanceLessonId: attendanceLessonId ?? this.attendanceLessonId,
      qrCodeData: qrCodeData ?? this.qrCodeData,
      qrCodeLocation: qrCodeLocation ?? this.qrCodeLocation,
      qrCodeTimeLimit: qrCodeTimeLimit ?? this.qrCodeTimeLimit,
      qrCodeTimeLimitType: qrCodeTimeLimitType ?? this.qrCodeTimeLimitType,
      qrAttendanceClass: qrAttendanceClass ?? this.qrAttendanceClass,
      createdDate: createdDate ?? this.createdDate,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'qrAttendanceId': qrAttendanceId,
      'attendanceLessonId': attendanceLessonId,
      'qrCodeData': qrCodeData,
      'qrCodeLocation': qrCodeLocation,
      'qrCodeTimeLimit': qrCodeTimeLimit,
      'qrCodeTimeLimitType': qrCodeTimeLimitType,
      'qrAttendanceClass': qrAttendanceClass,
      'created_date': createdDate,
    };
  }

  @override
  QrAttendanceModel fromJson(Map<String, dynamic> json) {
    return QrAttendanceModel(
      qrAttendanceId: json['qrAttendanceId'] as String?,
      attendanceLessonId: json['attendanceLessonId'] as String?,
      qrCodeData: json['qrCodeData'] as String?,
      qrCodeLocation: json['qrCodeLocation'] as String?,
      qrCodeTimeLimit: json['qrCodeTimeLimit'] as int?,
      qrCodeTimeLimitType: json['qrCodeTimeLimitType'] as String?,
      qrAttendanceClass: json['qrAttendanceClass'] as int?,
      createdDate: json['created_date'] as Timestamp?,
    );
  }
}
