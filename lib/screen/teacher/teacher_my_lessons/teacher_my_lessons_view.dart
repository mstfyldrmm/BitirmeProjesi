import 'package:qr_attendance_project/export.dart';

class TeacherMyLessonsView with ChangeNotifier {
  ValueNotifier<List<LessonModel?>> teacherLesson = ValueNotifier([]);

  Future<List<LessonModel?>> getTeacherLessons(String teacherId) async {
    teacherLesson.value = await TeacherService().fetchTeacherLessons(teacherId);
    return teacherLesson.value;
  }

  Future<void> deleteTeacherLesson(String lessonId) async {
    await TeacherService().deleteLessonFirebase(lessonId);
    teacherLesson.value.removeWhere((lesson) => lesson!.lessonId == lessonId);
    teacherLesson.notifyListeners();
  }
}
