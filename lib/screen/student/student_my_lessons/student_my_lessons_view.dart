import 'package:flutter/cupertino.dart';
import 'package:qr_attendance_project/model/lesson_model.dart';
import 'package:qr_attendance_project/services/student_services/student_service.dart';

class StudentMyLessonsView extends ChangeNotifier {
  ValueNotifier<List<LessonModel?>> studentLessonsNotifier = ValueNotifier([]);

  Future<List<LessonModel?>> getLessons(String studentId) async {
    studentLessonsNotifier.value =
        await StudentService().fetchStudentLessons(studentId);
    return studentLessonsNotifier.value;
  }
}
