import 'package:qr_attendance_project/export.dart';

class TeacherService {
  final _teacherCollection = FirebaseCollections.teachers.reference;
  final _lessonsCollection = FirebaseCollections.lessons.reference;

  final _logger = Logger(printer: PrettyPrinter());

  Future<TeacherModel?> fetchTeacher(String teacherId) async {
    try {
      final responseTeacher = await _teacherCollection
          .doc(teacherId)
          .withConverter(
            fromFirestore: (snapshot, _) {
              return TeacherModel().fromFirebase(snapshot);
            },
            toFirestore: (value, _) => {},
          )
          .get();

      final teacherData = responseTeacher.data();
      return teacherData;
    } catch (e) {
      _logger.e('error: $e');
      return null;
    }
  }

  Future<List<LessonModel?>> fetchTeacherLessons(String teacherId) async {
    try {
      final teacherData = await fetchTeacher(teacherId);

      if (teacherData == null || teacherData.lessons == null) {
        _logger.i('Öğrencinin dersi bulunmamaktadır');
        return [];
      }

      final lessonIds = teacherData.lessons!;

      final List<LessonModel> teacherLessons = [];

      for (String lessonId in lessonIds) {
        final lessonSnapshotData = await _lessonsCollection
            .doc(lessonId)
            .withConverter(
              fromFirestore: (snapshot, _) {
                return LessonModel().fromFirebase(snapshot);
              },
              toFirestore: (value, _) => {},
            )
            .get();

        final lessonData = lessonSnapshotData.data();
        if (lessonData != null) {
          teacherLessons.add(lessonData);
        }
      }
      _logger.i('Öğrencinin dersleri başarıyla çekildi!!!');
      return teacherLessons;
    } catch (e) {
      _logger.e('from fetchStudentLessons error: $e');
      return [];
    }
  }
}
