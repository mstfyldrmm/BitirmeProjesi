import 'package:qr_attendance_project/export.dart';

class TeacherMainView {
  ValueNotifier<List<LessonModel?>> teacherLesson = ValueNotifier([]);

  Future<List<LessonModel?>> getTeacherLessons(String teacherId) async {
    teacherLesson.value = await TeacherService().fetchTeacherLessons(teacherId);
    return teacherLesson.value;
  }
}
