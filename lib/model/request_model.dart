import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:qr_attendance_project/model/base_model.dart';

class RequestModel extends BaseModel<RequestModel> with EquatableMixin {
  Timestamp? requestDate;
  String? requestDescription;
  int? requestType;
  String? requestId;
  String? requestLessonId;
  String? requestStudentId;
  String? requestLesson;
  String? requestAttendanceDate;
  bool? requestState;

  RequestModel(
      {this.requestDate,
      this.requestDescription,
      this.requestId,
      this.requestLessonId,
      this.requestState,
      this.requestLesson,
      this.requestAttendanceDate,
      this.requestStudentId,
      this.requestType});

  @override
  List<Object?> get props => [
        requestDate,
        requestDescription,
        requestAttendanceDate,
        requestId,
        requestType,
        requestLessonId,
        requestStudentId,
        requestLesson,
        requestState
      ];

  RequestModel copyWith({
    Timestamp? requestDate,
    String? requestDescription,
    String? requestId,
    int? requestType,
    String? requestLessonId,
    String? requestStudentId,
    String? requestAttendanceDate,
    String? requestLesson,
    bool? requestState,
  }) {
    return RequestModel(
      requestDate: requestDate ?? this.requestDate,
      requestDescription: requestDescription ?? this.requestDescription,
      requestId: requestId ?? this.requestId,
      requestStudentId: requestStudentId ?? this.requestStudentId,
      requestState: requestState ?? this.requestState,
      requestLesson: requestLesson ?? this.requestLesson,
      requestAttendanceDate: requestAttendanceDate ?? this.requestAttendanceDate,
      requestType: requestType ?? this.requestType,
      requestLessonId: requestLessonId ?? this.requestLessonId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'requestDate': requestDate,
      'requestDescription': requestDescription,
      'requestId': requestId,
      'requestAttendanceDate': requestAttendanceDate,
      'requestStudentId': requestStudentId,
      'requestLessonId': requestLessonId,
      'requestState': requestState,
      'requestType': requestType,
      'requestLesson': requestLesson,
    };
  }

  @override
  RequestModel fromJson(Map<String, dynamic> json) {
    return RequestModel(
      requestDate: json['requestDate'] as Timestamp?,
      requestDescription: json['requestDescription'] as String?,
      requestAttendanceDate: json['requestAttendanceDate'] as String?,
      requestId: json['requestId'] as String?,
      requestStudentId: json['requestStudentId'] as String?,
      requestType: json['requestType'] as int?,
      requestLessonId: json['requestLessonId'] as String?,
      requestState: json['requestState'] as bool?,
      requestLesson: json['requestLesson'] as String?,
    );
  }
}
