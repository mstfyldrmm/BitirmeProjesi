import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:qr_attendance_project/custom/enums/firebase_collections.dart';
import 'package:qr_attendance_project/model/lesson_model.dart';

class StudentService {
  final _studentCollection = FirebaseCollections.students.reference;

  final User? _currentUser = FirebaseAuth.instance.currentUser;

  var _logger = Logger(printer: PrettyPrinter());

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
}
