import 'package:qr_attendance_project/export.dart';

class StudentMyLessonsView extends ChangeNotifier {
  ValueNotifier<List<LessonModel?>> studentLessonsNotifier = ValueNotifier([]);
  ValueNotifier<List<LessonModel?>> studentFilteredLessonsNotifier =
      ValueNotifier([]);
  ValueNotifier<StudentModel?> studentNotifier = ValueNotifier(null);
  ValueNotifier<bool> isLoading = ValueNotifier(true);
  

  Future<List<LessonModel?>> getLessons(String studentId) async {
    studentLessonsNotifier.value =
        await StudentService().fetchStudentLessons(studentId);
    studentFilteredLessonsNotifier.value = studentLessonsNotifier.value;
    isLoading.value = false;
    return studentLessonsNotifier.value;
  }

  Future<StudentModel?> getCurrentStudent(String studentId) async {
    studentNotifier.value = await StudentService().fetchStudent(studentId);
    return studentNotifier.value;
  }

  void filterLessons(String query) {
    if (query.isEmpty) {
      studentFilteredLessonsNotifier.value = studentLessonsNotifier.value;
    } else {
      final lowerQuery = query.toLowerCase();
      studentFilteredLessonsNotifier.value =
          studentLessonsNotifier.value.where((lesson) {
        final name = lesson?.lessonName?.toLowerCase() ?? '';
        final code = lesson?.lessonCode?.toLowerCase() ?? '';
        return name.contains(lowerQuery) || code.contains(lowerQuery);
      }).toList();
    }
  }
}
