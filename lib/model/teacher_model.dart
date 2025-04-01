import 'package:equatable/equatable.dart';
import 'package:qr_attendance_project/model/base_model.dart';

class TeacherModel extends BaseModel<TeacherModel> with EquatableMixin {
  String? teacherId;
  String? teacherName;
  String? teacherSurname;
  String? teacherMailAdress;
  List<String>? lessons;

  TeacherModel({
    this.teacherId,
    this.teacherName,
    this.teacherSurname,
    this.teacherMailAdress,
    this.lessons,
  });

  @override
  List<Object?> get props =>
      [teacherId, teacherName, teacherSurname, teacherMailAdress, lessons];

  TeacherModel copyWith({
    String? teacherId,
    String? teacherName,
    String? teacherSurname,
    String? teacherMailAdress,
    List<String>? lessons,
  }) {
    return TeacherModel(
      teacherId: teacherId ?? this.teacherId,
      teacherName: teacherName ?? this.teacherName,
      teacherSurname: teacherSurname ?? this.teacherSurname,
      teacherMailAdress: teacherMailAdress ?? this.teacherMailAdress,
      lessons: lessons ?? this.lessons,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'teacherId': teacherId,
      'teacherName': teacherName,
      'teacherSurname': teacherSurname,
      'teacherMailAdress': teacherMailAdress,
      'lessons': lessons,
    };
  }

  @override
  TeacherModel fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      teacherId: json['teacherId'] as String?,
      teacherName: json['teacherName'] as String?,
      teacherSurname: json['teacherSurname'] as String?,
      teacherMailAdress: json['teacherMailAdress'] as String?,
      lessons:
          (json['lessons'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );
  }
}
