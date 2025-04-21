import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<String?> addLessonFirebase(LessonModel lesson) async {
    bool isAvaible = await checkLessonFirebase(lesson.lessonCode!);
    try {
      if (isAvaible) {
        String lessonId = _lessonsCollection.doc().id;
        await _lessonsCollection
            .doc(lessonId)
            .set(lesson.copyWith(lessonId: lessonId).toJson());
        _logger.d('Ders eklendi');
        showToast('Ders Oluşturma İşlemi Başarılı', isError: false);
        return lessonId;
      } else {
        _logger.e('Ders kodu mevcut, ders eklenemedi');
        showToast('Ders kodu mevcut, ders eklenemedi', isError: true);
        return null;
      }
    } catch (e) {
      _logger.e('Ders eklenmedi, hata kodu: ${e}');
      showToast(
          'Ders Oluşturma İşlemi sırasında hata meydana geldi. Lütfen tekrar deneyin',
          isError: true);
      return null;
    }
  }

  Future<bool> checkLessonFirebase(String lessonCode) async {
    try {
      var value = await _lessonsCollection
          .where('lessonCode', isEqualTo: lessonCode)
          .get();
      if (value.docs.isEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      _logger.e('Ders kodu kontrol edilirken hata meydana geldi: $e');
      showToast(
          'Ders kodu kontrol edilirken hata meydana geldi. Lütfen tekrar deneyin.',
          isError: true);
      return false;
    }
  }

  Future<bool> addLessonTeacher(String userId, String lessonId) async {
    try {
      await _teacherCollection.doc(userId).update({
        'lessons': FieldValue.arrayUnion([lessonId])
      });
      _logger.i(
          "Lesson added successfully to teacher: $userId lessonId: $lessonId");
      showToast('Ders öğretmene başarıyla eklendi', isError: false);
      return true;
    } catch (e) {
      _logger.e("Error adding lesson: $e");
      showToast("Ders öğretmene eklerken sorun oluştu: ${e}", isError: true);
      return false;
    }
  }

  Future<bool> deleteLessonFirebase(String lessonId) async {
    try {
      await _lessonsCollection.doc(lessonId).delete();
      _logger.i("Lesson deleted successfully: $lessonId");
      showToast('Ders başarıyla silindi', isError: false);
      return true;
    } catch (e) {
      _logger.e("Error deleting lesson: $e");
      showToast("Ders silinirken sorun oluştu: ${e}", isError: true);
      return false;
    }
  }

  Future<List<LessonModel?>> fetchTeacherLessons(String teacherId) async {
    try {
      final teacherData = await fetchTeacher(teacherId);

      if (teacherData == null || teacherData.lessons == null) {
        _logger.i('Öğretmenin dersi bulunmamaktadır');
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
      _logger.i('Öğretmenin dersleri başarıyla çekildi!!!');
      return teacherLessons;
    } catch (e) {
      _logger.e('from fetchTeacherLessons error: $e');
      return [];
    }
  }
}
