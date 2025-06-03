import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:qr_attendance_project/model/base_model.dart';

class RequestModel extends BaseModel<RequestModel> with EquatableMixin {
  Timestamp? requestDate;
  String? requestDescription;
  int? requestType;
  String? requestId;
  String? requestStudentId;
  String? requestLesson;
  bool? requestState;

  RequestModel(
      {this.requestDate,
      this.requestDescription,
      this.requestId,
      this.requestState,
      this.requestLesson,
      this.requestStudentId,
      this.requestType});

  @override
  List<Object?> get props => [
        requestDate,
        requestDescription,
        requestId,
        requestType,
        requestStudentId,
        requestLesson,
        requestState
      ];

  RequestModel copyWith({
    Timestamp? requestDate,
    String? requestDescription,
    String? requestId,
    int? requestType,
    String? requestStudentId,
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
      requestType: requestType ?? this.requestType,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'requestDate': requestDate,
      'requestDescription': requestDescription,
      'requestId': requestId,
      'requestStudentId': requestStudentId,
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
      requestId: json['requestId'] as String?,
      requestStudentId: json['requestStudentId'] as String?,
      requestType: json['requestType'] as int?,
      requestState: json['requestState'] as bool?,
      requestLesson: json['requestLesson'] as String?,
    );
  }
}
