import 'package:equatable/equatable.dart';
import 'package:qr_attendance_project/model/base_model.dart';

class LessonModel extends BaseModel<LessonModel> with EquatableMixin {
  String? lessonId;
  String? lessonName;
  int? lessonCode;
  String? section;
  String? teacherName;
  int? totalStudent;

  LessonModel({
    this.lessonId,
    this.lessonName,
    this.lessonCode,
    this.section,
    this.teacherName,
    this.totalStudent,
  });

  @override
  List<Object?> get props =>
      [lessonId, lessonName, lessonCode, section, teacherName, totalStudent];

  LessonModel copyWith({
    String? lessonId,
    String? lessonName,
    int? lessonCode,
    String? section,
    String? teacherName,
    int? totalStudent,
  }) {
    return LessonModel(
      lessonId: lessonId ?? this.lessonId,
      lessonName: lessonName ?? this.lessonName,
      lessonCode: lessonCode ?? this.lessonCode,
      section: section ?? this.section,
      teacherName: teacherName ?? this.teacherName,
      totalStudent: totalStudent ?? this.totalStudent,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lessonId': lessonId,
      'lessonName': lessonName,
      'lessonCode': lessonCode,
      'section': section,
      'teacherName': teacherName,
      'totalStudent': totalStudent,
    };
  }

  @override
  LessonModel fromJson(Map<String, dynamic> json) {
    return LessonModel(
      lessonId: json['lessonId'] as String?,
      lessonName: json['lessonName'] as String?,
      lessonCode: json['lessonCode'] as int?,
      section: json['section'] as String?,
      teacherName: json['teacherName'] as String?,
      totalStudent: json['totalStudent'] as int?,
    );
  }
}
