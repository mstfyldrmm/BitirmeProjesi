import 'package:equatable/equatable.dart';
import 'package:qr_attendance_project/model/base_model.dart';

class LessonModel extends BaseModel<LessonModel> with EquatableMixin {
  String? lessonId;
  String? lessonName;
  String? lessonCode;
  String? section;
  String? teacherName;
  List<String>? students;

  LessonModel({
    this.lessonId,
    this.lessonName,
    this.lessonCode,
    this.section,
    this.teacherName,
    this.students,
  });

  @override
  List<Object?> get props =>
      [lessonId, lessonName, lessonCode, section, teacherName, students];

  LessonModel copyWith({
    String? lessonId,
    String? lessonName,
    String? lessonCode,
    String? section,
    String? teacherName,
    List<String>? students,
  }) {
    return LessonModel(
      lessonId: lessonId ?? this.lessonId,
      lessonName: lessonName ?? this.lessonName,
      lessonCode: lessonCode ?? this.lessonCode,
      section: section ?? this.section,
      teacherName: teacherName ?? this.teacherName,
      students: students ?? this.students,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lessonId': lessonId,
      'lessonName': lessonName,
      'lessonCode': lessonCode,
      'section': section,
      'teacherName': teacherName,
      'students': students,
    };
  }

  @override
  LessonModel fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return LessonModel(
      lessonId: json['lessonId'] as String?,
      lessonName: json['lessonName'] as String?,
      lessonCode: json['lessonCode'] as String?,
      section: json['section'] as String?,
      teacherName: json['teacherName'] as String?,
      students: (json['students'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }
}
