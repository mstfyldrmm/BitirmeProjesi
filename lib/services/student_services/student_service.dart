import 'package:qr_attendance_project/export.dart';

class StudentService {
  final _studentCollection = FirebaseCollections.students.reference;
  final _lessonsCollection = FirebaseCollections.lessons.reference;

  final _logger = Logger(printer: PrettyPrinter());

  Future<StudentModel?> fetchStudent(String studentId) async {
    try {
      final responseStudent = await _studentCollection
          .doc(studentId)
          .withConverter(
            fromFirestore: (snapshot, _) {
              return StudentModel().fromFirebase(snapshot);
            },
            toFirestore: (value, _) => {},
          )
          .get();

      final studentData = responseStudent.data();
      return studentData;
    } catch (e) {
      _logger.e('error: $e');
      return null;
    }
  }

  Future<bool> addLesson(LessonModel? lessonModel, String userId) async {
    try {
      await _studentCollection.doc(userId).set({
        'lessons': lessonModel?.lessonId,
      });
      _logger.i("Lesson added successfully to student: $userId");
      return true;
    } catch (e) {
      _logger.e("Error adding lesson: $e");
      return false;
    }
  }

  Future<List<LessonModel?>> fetchStudentLessons(String studentId) async {
    try {
      final studentData = await fetchStudent(studentId);

      if (studentData == null || studentData.lessons == null) {
        _logger.i('Öğrencinin dersi bulunmamaktadır');
        return [];
      }

      final lessonIds = studentData.lessons!;

      final List<LessonModel> studentLessons = [];

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
          studentLessons.add(lessonData);
        }
      }
      _logger.i('Öğrencinin dersleri başarıyla çekildi!!!');
      return studentLessons;
    } catch (e) {
      _logger.e('from fetchStudentLessons error: $e');
      return [];
    }
  }
}
