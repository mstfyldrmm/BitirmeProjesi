import 'package:qr_attendance_project/export.dart';

class StudentMyLessonsView extends ChangeNotifier {
  ValueNotifier<List<LessonModel?>> studentLessonsNotifier = ValueNotifier([]);

  Future<List<LessonModel?>> getLessons(String studentId) async {
    studentLessonsNotifier.value =
        await StudentService().fetchStudentLessons(studentId);
    return studentLessonsNotifier.value;
  }
}
