import 'package:qr_attendance_project/export.dart';

class StudentMyLessonsView extends ChangeNotifier {
  ValueNotifier<List<LessonModel?>> studentLessonsNotifier = ValueNotifier([]);
  ValueNotifier<List<LessonModel?>> studentFilteredLessonsNotifier = ValueNotifier([]);

  Future<List<LessonModel?>> getLessons(String studentId) async {
    studentLessonsNotifier.value =
        await StudentService().fetchStudentLessons(studentId);
    studentFilteredLessonsNotifier.value = studentLessonsNotifier.value;
    return studentLessonsNotifier.value;
  }

  void filterLessons(String query) {
    if (query.isEmpty) {
      studentFilteredLessonsNotifier.value = studentLessonsNotifier.value;
    } else {
      studentFilteredLessonsNotifier.value = studentLessonsNotifier.value
          .where(
            (lesson) => (lesson?.lessonName ?? '')
                .toLowerCase()
                .contains(query.toLowerCase()),
          )
          .toList();
    }
  }
}
