import 'package:equatable/equatable.dart';
import 'package:qr_attendance_project/model/base_model.dart';

class LessonModel extends BaseModel<LessonModel> with EquatableMixin {
  String? lessonId;
  String? lessonName;
  String? lessonCode;
  String? section;
  String? teacherName;
  String? classLevel;
  int? lessonAttendancePercent;
  int? totalAttendanceCount;
  List<String>? students;

  LessonModel({
    this.lessonId,
    this.lessonName,
    this.lessonCode,
    this.section,
    this.classLevel,
    this.lessonAttendancePercent,
    this.teacherName,
    this.totalAttendanceCount,
    this.students,
  });

  @override
  List<Object?> get props => [
        lessonId,
        lessonName,
        lessonCode,
        section,
        classLevel,
        lessonAttendancePercent,
        teacherName,
        totalAttendanceCount,
        students
      ];

  LessonModel copyWith({
    String? lessonId,
    String? lessonName,
    String? lessonCode,
    String? section,
    String? classLevel,
    String? teacherName,
    int? totalAttendanceCount,
    List<String>? students,
  }) {
    return LessonModel(
      lessonId: lessonId ?? this.lessonId,
      lessonName: lessonName ?? this.lessonName,
      lessonCode: lessonCode ?? this.lessonCode,
      section: section ?? this.section,
      classLevel: classLevel ?? this.classLevel,
      lessonAttendancePercent:  lessonAttendancePercent ?? this.lessonAttendancePercent,
      teacherName: teacherName ?? this.teacherName,
      totalAttendanceCount: totalAttendanceCount ?? this.totalAttendanceCount,
      students: students ?? this.students,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lessonId': lessonId,
      'lessonName': lessonName,
      'lessonCode': lessonCode,
      'section': section,
      'classLevel': classLevel,
      'lessonAttendancePercent' : lessonAttendancePercent,
      'teacherName': teacherName,
      'totalAttendanceCount': totalAttendanceCount,
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
      classLevel: json['classLevel'] as String?,
      lessonAttendancePercent: json['lessonAttendancePercent'] as int?,
      teacherName: json['teacherName'] as String?,
      totalAttendanceCount: json['totalAttendanceCount'] as int?,
      students: (json['students'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }
}
