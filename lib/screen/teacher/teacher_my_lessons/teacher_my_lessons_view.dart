import 'package:qr_attendance_project/export.dart';

class TeacherMyLessonsView extends ChangeNotifier {
  ValueNotifier<List<LessonModel?>> teacherLessons = ValueNotifier([]);
  ValueNotifier<List<LessonModel?>> teacherFilteredLessons = ValueNotifier([]);
  ValueNotifier<bool> isLoading = ValueNotifier(true);

  Future<List<LessonModel?>> getTeacherLessons(String teacherId) async {
    teacherLessons.value =
        await TeacherService().fetchTeacherLessons(teacherId);
    teacherFilteredLessons.value = teacherLessons.value;
    isLoading.value = false;
    return teacherLessons.value;
  }

  void filterLessons(String query) {
    if (query.isEmpty) {
      teacherFilteredLessons.value = teacherLessons.value;
    } else {
      final lowerQuery = query.toLowerCase();
      teacherFilteredLessons.value = teacherLessons.value;
      teacherFilteredLessons.value = teacherLessons.value.where((lesson) {
        final name = lesson?.lessonName?.toLowerCase() ?? '';
        final code = lesson?.lessonCode?.toLowerCase() ?? '';
        return name.contains(lowerQuery) || code.contains(lowerQuery);
      }).toList();
    }
  }

  Future<void> deleteTeacherLesson(String lessonId) async {
    await TeacherService().deleteLessonFirebase(lessonId);
    teacherLessons.value.removeWhere((lesson) => lesson!.lessonId == lessonId);
    teacherLessons.notifyListeners();
  }
}
