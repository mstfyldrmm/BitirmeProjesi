import 'package:qr_attendance_project/export.dart';

class TeacherMyLessonsView extends ChangeNotifier {
  ValueNotifier<List<LessonModel?>> teacherLessons = ValueNotifier([]);
  ValueNotifier<List<LessonModel?>> teacherFilteredLessons = ValueNotifier([]);

  Future<List<LessonModel?>> getTeacherLessons(String teacherId) async {
    teacherLessons.value = await TeacherService().fetchTeacherLessons(teacherId);
    teacherFilteredLessons.value = teacherLessons.value;
    return teacherLessons.value;
  }

  void filterLessons(String query) {
    if (query.isEmpty) {
      teacherFilteredLessons.value = teacherLessons.value;
    } else {
      teacherFilteredLessons.value = teacherLessons.value
          .where(
            (lesson) => (lesson?.lessonName ?? '')
            .toLowerCase()
            .contains(query.toLowerCase()),
      )
          .toList();
    }
  }

  Future<void> deleteTeacherLesson(String lessonId) async {
    await TeacherService().deleteLessonFirebase(lessonId);
    teacherLessons.value.removeWhere((lesson) => lesson!.lessonId == lessonId);
    teacherLessons.notifyListeners();
  }
}
