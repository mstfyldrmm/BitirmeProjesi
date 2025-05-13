import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_attendance_project/export.dart';

class StudentService {
  final _studentCollection = FirebaseCollections.students.reference;
  final _lessonsCollection = FirebaseCollections.lessons.reference;
  final _teachersCollection = FirebaseCollections.teachers.reference;
  final _requestsCollection = FirebaseCollections.requests.reference;

  final _logger = Logger(printer: PrettyPrinter());

  /// returns all students
  Future<List<StudentModel?>> fetchAllStudents() async {
    try {
      final response = await _studentCollection
          .withConverter(
            fromFirestore: (snapshot, _) {
              return StudentModel().fromFirebase(snapshot);
            },
            toFirestore: (value, _) => {},
          )
          .get();

      final students = response.docs.map((doc) => doc.data()).toList();
      _logger.i("Fetch all students successfully");
      return students;
    } catch (e) {
      _logger.e('error: $e');
      return [];
    }
  }

  /// Updates students' course information
  Future<bool> updateStudentsWithLesson({
    required List<String> studentsIds,
    required String lessonId,
  }) async {
    try {
      final responseStudents = await _studentCollection
          .withConverter(
            fromFirestore: (snapshot, _) {
              return StudentModel().fromFirebase(snapshot);
            },
            toFirestore: (value, _) => {},
          )
          .get();

      final allStudents = responseStudents.docs;

      final batch = FirebaseFirestore.instance.batch();

      int counter = 0;

      for (final studentDoc in allStudents) {
        final student = studentDoc.data();
        final studentId = student?.studentId;

        if (studentsIds.contains(studentId)) {
          final docRef = _studentCollection.doc(studentId);
          batch.update(docRef, {
            'lessons': FieldValue.arrayUnion([lessonId]),
          });

          counter++;

          /// If we reach the batch limit of 500,
          /// commit the batch and start a new one.
          if (counter == 500) {
            await batch.commit();
            counter = 0;
          }
        }
      }
      if (counter > 0) {
        await batch.commit();
      }
      _logger.i('Students lesson information has been updated successfully.');
      return true;
    } catch (e) {
      _logger.e('Error: $e');
      return false;
    }
  }

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
      _logger.i("Fetch student successfully: $studentId");
      return studentData;
    } catch (e) {
      _logger.e('error: $e');
      return null;
    }
  }

  Future<bool> addLessonStudent(String userId, String lessonId) async {
    try {
      await _studentCollection.doc(userId).update({
        'lessons': FieldValue.arrayUnion([lessonId])
      });
      _logger.i(
          "Lesson added successfully to student: $userId lessonId: $lessonId");
      return true;
    } catch (e) {
      _logger.e("Error adding lesson: $e");
      return false;
    }
  }

  Future<bool> addRequestsStudent(String userId, String requestId) async {
    try {
      await _studentCollection.doc(userId).update({
        'requests': FieldValue.arrayUnion([requestId])
      });
      _logger.i(
          "Request added successfully to student: $userId requestId: $requestId");
      showToast(
          '${LocaleKeys.studentRequest_requestAddFirebaseSuccessMessage.locale}',
          isError: false);
      return true;
    } catch (e) {
      _logger.e("Error adding request: $e");
      showToast(
          '${LocaleKeys.errorCode_request_requestAddStudentErrorMessage.locale}',
          isError: true);
      return false;
    }
  }

  Future<String?> addRequestFirebase(RequestModel request) async {
    try {
      String requestId = _requestsCollection.doc().id;
      await _requestsCollection
          .doc(requestId)
          .set(request.copyWith(requestId: requestId).toJson());
      _logger.d('Istek eklendi');
      showToast(
          LocaleKeys.studentRequest_requestAddFirebaseSuccessMessage.locale,
          isError: false);
      return requestId;
    } catch (e) {
      _logger.e('Istek eklenmedi, hata kodu: ${e}');
      showToast(
          LocaleKeys.errorCode_request_requestAddStudentErrorMessage.locale,
          isError: true);
      return null;
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

  Future<List<RequestModel?>> fetchStudentRequests(String studentId) async {
    try {
      final studentData = await fetchStudent(studentId);

      if (studentData == null || studentData.requests == null) {
        _logger.i('Öğrencinin talebi bulunmamaktadır');
        return [];
      }

      final requestIds = studentData.requests!;

      final List<RequestModel> studentRequests = [];

      for (String requestId in requestIds) {
        final requestSnapshotData = await _requestsCollection
            .doc(requestId)
            .withConverter(
              fromFirestore: (snapshot, _) {
                return RequestModel().fromFirebase(snapshot);
              },
              toFirestore: (value, _) => {},
            )
            .get();

        final requestData = requestSnapshotData.data();
        if (requestData != null) {
          studentRequests.add(requestData);
        }
      }
      _logger.i('Öğrencinin talepleri başarıyla çekildi!!!');
      return studentRequests;
    } catch (e) {
      _logger.e('from fetchStudentRequests error: $e');
      return [];
    }
  }
}
