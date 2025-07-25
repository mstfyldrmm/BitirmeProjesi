import 'package:equatable/equatable.dart';
import 'package:qr_attendance_project/model/base_model.dart';

class StudentModel extends BaseModel<StudentModel> with EquatableMixin {
  String? studentId;
  String? mailAddress;
  List<String>? lessons;
  List<String>? requests;
  String? studentName;
  String? studentSurname;
  int? schoolNumber;

  StudentModel({
    this.studentId,
    this.mailAddress,
    this.lessons,
    this.requests,
    this.studentName,
    this.studentSurname,
    this.schoolNumber,
  });

  @override
  List<Object?> get props => [
        studentId,
        mailAddress,
        lessons,
        requests,
        studentName,
        studentSurname,
        schoolNumber
      ];

  StudentModel copyWith({
    String? studentId,
    String? mailAddress,
    List<String>? lessons,
    List<String>? requests,
    String? studentName,
    String? studentSurname,
    int? schoolNumber,
  }) {
    return StudentModel(
      studentId: studentId ?? this.studentId,
      mailAddress: mailAddress ?? this.mailAddress,
      lessons: lessons ?? this.lessons,
      requests: requests ?? this.requests,
      studentName: studentName ?? this.studentName,
      studentSurname: studentSurname ?? this.studentSurname,
      schoolNumber: schoolNumber ?? this.schoolNumber,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'mailAddress': mailAddress,
      'lessons': lessons,
      'requests': requests,
      'studentName': studentName,
      'studentSurname': studentSurname,
      'schoolNumber': schoolNumber,
    };
  }

  @override
  StudentModel fromJson(Map<String, dynamic> json) {
    return StudentModel(
      studentId: json['studentId'] as String?,
      mailAddress: json['mailAddress'] as String?,
      lessons:
          (json['lessons'] as List<dynamic>?)?.map((e) => e as String).toList(),
      requests: (json['requests'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      studentName: json['studentName'] as String?,
      studentSurname: json['studentSurname'] as String?,
      schoolNumber: json['schoolNumber'] as int?,
    );
  }
}
