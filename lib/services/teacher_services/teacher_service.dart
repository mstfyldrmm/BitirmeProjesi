import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_attendance_project/export.dart';

class TeacherService {
  final _teacherCollection = FirebaseCollections.teachers.reference;
  final _lessonsCollection = FirebaseCollections.lessons.reference;
  final _requestsCollection = FirebaseCollections.requests.reference;

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

  Future<List<TeacherModel>> fetchAllTeachers() async {
    try {
      QuerySnapshot querySnapshot = await _teacherCollection.get();
      List<TeacherModel> teacherList = [];

      for (var doc in querySnapshot.docs) {
        teacherList
            .add(TeacherModel().fromJson(doc.data() as Map<String, dynamic>));
      }

      return teacherList;
    } catch (e) {
      print('Error fetching teachers: $e');
      return [];
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
        showToast(
            LocaleKeys.teacherAddLesson_successMessage_addLessonFirebaseMessage
                .locale,
            isError: false);
        return lessonId;
      } else {
        _logger.e('Ders kodu mevcut, ders eklenemedi');
        showToast(LocaleKeys.errorCode_teacherAddLesson_lessonCode.locale,
            isError: true);
        return null;
      }
    } catch (e) {
      _logger.e('Ders eklenmedi, hata kodu: ${e}');
      showToast(
          LocaleKeys.errorCode_teacherAddLesson_addLessonFirebaseMessage.locale,
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
      showToast(LocaleKeys.errorCode_teacherAddLesson_lessonCodeCheck.locale,
          isError: true);
      return false;
    }
  }

  Future<LessonModel?> fetchLessonInfo(String lessonId) async {
    try {
      final responseLesson = await _lessonsCollection
          .doc(lessonId)
          .withConverter(
            fromFirestore: (snapshot, _) {
              return LessonModel().fromFirebase(snapshot);
            },
            toFirestore: (value, _) => {},
          )
          .get();

      final lessonData = responseLesson.data();
      return lessonData;
    } catch (e) {
      _logger.e('error: $e');
      return null;
    }
  }

  Future<bool> addLessonTeacher(String userId, String lessonId) async {
    try {
      await _teacherCollection.doc(userId).update({
        'lessons': FieldValue.arrayUnion([lessonId])
      });
      _logger.i(
          "Lesson added successfully to teacher: $userId lessonId: $lessonId");
      showToast(
          LocaleKeys.teacherAddLesson_successMessage_addLessonTeacher.locale,
          isError: false);
      return true;
    } catch (e) {
      _logger.e("Error adding lesson: $e");
      showToast(LocaleKeys.errorCode_teacherAddLesson_addLessonTeacher.locale,
          isError: true);
      return false;
    }
  }

  Future<bool> deleteLessonFirebase(String lessonId) async {
    try {
      await _lessonsCollection.doc(lessonId).delete();
      _logger.i("Lesson deleted successfully: $lessonId");
      showToast(LocaleKeys.teacherAddLesson_successMessage_lessonDelete.locale,
          isError: false);
      return true;
    } catch (e) {
      _logger.e("Error deleting lesson: $e");
      showToast(LocaleKeys.errorCode_teacherAddLesson_lessonDelete.locale,
          isError: true);
      return false;
    }
  }

  Future<bool> addRequestTeacher(String teacherId, String requestId) async {
    try {
      await _teacherCollection.doc(teacherId).update({
        'requests': FieldValue.arrayUnion([requestId])
      });
      _logger.i(
          "Request added successfully to student: $teacherId requestId: $requestId");
      showToast(
          '${LocaleKeys.studentRequest_requestAddTeacherSuccessMessage.locale}',
          isError: false);
      return true;
    } catch (e) {
      _logger.e("Error adding request: $e");
      showToast(
          '${LocaleKeys.errorCode_request_requestAddTeacherErrorMessage.locale}',
          isError: true);
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

      final lessonsIds = teacherData.lessons!;

      final List<LessonModel?> allLessons = [];

      const int chunkSize = 30;

      for (var i = 0; i < lessonsIds.length; i += chunkSize) {
        final chunk = lessonsIds.sublist(
          i,
          i + chunkSize > lessonsIds.length ? lessonsIds.length : i + chunkSize,
        );

        final lessonsQuery = await FirebaseFirestore.instance
            .collection('lessons')
            .where(FieldPath.documentId, whereIn: chunk)
            .withConverter(
              fromFirestore: (snapshot, _) =>
                  LessonModel().fromFirebase(snapshot),
              toFirestore: (lesson, _) => {},
            )
            .get();

        final lessons = lessonsQuery.docs.map((doc) => doc.data()).toList();
        allLessons.addAll(lessons);
      }

      _logger.i('Öğretmenin dersleri başarıyla çekildi!!!');
      return allLessons;
    } catch (e) {
      _logger.e('from fetchTeacherLessons error: $e');
      return [];
    }
  }

  Future<List<RequestModel?>> fetchTeacherRequests(String teacherId) async {
    try {
      final teacherData = await fetchTeacher(teacherId);

      if (teacherData == null || teacherData.requests == null) {
        _logger.i('Öğretmenin isteği bulunmamaktadır');
        return [];
      }

      final requestsIds = teacherData.requests!;

      final List<RequestModel?> allRequests = [];

      const int chunkSize = 30;

      for (var i = 0; i < requestsIds.length; i += chunkSize) {
        final chunk = requestsIds.sublist(
          i,
          i + chunkSize > requestsIds.length
              ? requestsIds.length
              : i + chunkSize,
        );

        final requestsQuery = await FirebaseFirestore.instance
            .collection('requests')
            .where(FieldPath.documentId, whereIn: chunk)
            .withConverter(
              fromFirestore: (snapshot, _) =>
                  RequestModel().fromFirebase(snapshot),
              toFirestore: (request, _) => {},
            )
            .get();

        final requests = requestsQuery.docs.map((doc) => doc.data()).toList();
        allRequests.addAll(requests);
      }

      _logger.i('Öğretmene ait talepler başarıyla çekildi!!!');
      return allRequests;
    } catch (e) {
      _logger.e('from fetchTeacherRequests error: $e');
      return [];
    }
  }

  Future<bool> updateRequestState(String requestId) async {
    try {
      await _requestsCollection.doc(requestId).update({'requestState': true});
      _logger.i("Request state successfully to true requestId: $requestId");
      showToast(
          '${LocaleKeys.studentRequest_requestAddTeacherSuccessMessage.locale}',
          isError: false);
      return true;
    } catch (e) {
      _logger.e("Error adding request: $e");
      showToast(
          '${LocaleKeys.errorCode_request_requestAddTeacherErrorMessage.locale}',
          isError: true);
      return false;
    }
  }
}
