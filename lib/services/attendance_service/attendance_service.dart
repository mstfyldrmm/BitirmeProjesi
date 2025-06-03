import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../../export.dart';

class AttendanceService {
  final _firstGradeReference =
      FirebaseCollections.firstGradeAttendance.reference;
  final _secondGradeReference =
      FirebaseCollections.secondGradeAttendance.reference;
  final _thirdGradeReference =
      FirebaseCollections.thirdGradeAttendance.reference;
  final _fourthGradeReference =
      FirebaseCollections.fourthGradeAttendance.reference;
  final _attendancesReference = FirebaseCollections.attendances.reference;
  final _studentsReference = FirebaseCollections.students.reference;
  final _lessonsCollection = FirebaseCollections.lessons.reference;

  final _logger = Logger(printer: PrettyPrinter());

  CollectionReference _getCollectionReference(String lessonClass) {
    return switch (lessonClass) {
      '1' => _firstGradeReference,
      '2' => _secondGradeReference,
      '3' => _thirdGradeReference,
      '4' => _fourthGradeReference,
      _ => throw Exception('Unknown lesson class'),
    };
  }

  Future<void> attendanceStart({
    required String lessonClass,
    required QrAttendanceModel qrAttendanceModel,
  }) async {
    try {
      final dateId = DateFormat('yyyy-MM-dd').format(DateTime.now());

      final collectionReference = _getCollectionReference(lessonClass);

      await collectionReference.doc(qrAttendanceModel.qrAttendanceId).set(
            qrAttendanceModel.toJson(),
          );

      final dateDocRef = _attendancesReference.doc(dateId);
      final dateDocSnapshot = await dateDocRef.get();

      if (!dateDocSnapshot.exists) {
        await dateDocRef.set({
          'createdAt': FieldValue.serverTimestamp(),
          'lessonIds': [qrAttendanceModel.attendanceLessonId],
        });
        await openAttendanceIfFirstToday(qrAttendanceModel.attendanceLessonId!);
      } else {
        final data = dateDocSnapshot.data() as Map<String, dynamic>?;
        final lessonIds = List<String>.from(data?['lessonIds'] ?? []);

        if (!lessonIds.contains(qrAttendanceModel.attendanceLessonId)) {
          lessonIds.add(qrAttendanceModel.attendanceLessonId!);
          await dateDocRef.update({'lessonIds': lessonIds});
          await openAttendanceIfFirstToday(
              qrAttendanceModel.attendanceLessonId!);
        }
      }

      _logger.i('Successfully attendanceStart...');
    } catch (e) {
      _logger.e('Error attendanceStart : $e');
    }
  }

  Future<void> attendanceFinished({
    required String lessonClass,
    required String attendanceId,
  }) async {
    try {
      final collectionReference = _getCollectionReference(lessonClass);

      await collectionReference.doc(attendanceId).delete();
      _logger.i('Successfully attendanceFinished...');
    } catch (e) {
      _logger.e('Error attendanceFinished : $e');
    }
  }

  Future<bool> takeClassAttendance({
    required String lessonClass,
    required AttendanceModel attendanceModel,
  }) async {
    try {
      final collectionReference = _getCollectionReference(lessonClass);

      final docSnapshot =
          await collectionReference.doc(attendanceModel.qrAttendanceId).get();

      if (docSnapshot.exists) {
        final dateId = DateFormat('yyyy-MM-dd').format(DateTime.now());

        final studentId = attendanceModel.studentId;
        final lessonId = attendanceModel.attendanceLessonId;

        if (studentId!.isNotEmpty && lessonId!.isNotEmpty) {
          final dateDocRef = _attendancesReference.doc(dateId);
          final studentDocRef = dateDocRef.collection(lessonId).doc(studentId);

          final studentDocSnapshot = await studentDocRef.get();

          if (studentDocSnapshot.exists) {
            _logger.w('Attendance already exists for student $studentId.');
            return false;
          }

          await dateDocRef.set({
            'createdAt': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));

          await studentDocRef.set(attendanceModel.toJson());

          final pastDateRef = _studentsReference
              .doc(studentId)
              .collection('pastPolls')
              .doc(dateId);

          await pastDateRef.set({
            'createdAt': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));

          await increaseStudentAttendance(
            studentId: studentId,
            lessonId: lessonId,
          );
          final pastLessonRef = pastDateRef.collection(lessonId).doc(lessonId);

          await pastLessonRef.set(attendanceModel.toJson());

          _logger.i(
            'Attendance data added under date $dateId and student $studentId.',
          );
          return true;
        } else {
          return false;
        }
      } else {
        _logger.w('No attendance document found');
        return false;
      }
    } catch (e) {
      _logger.e('Error takeClassAttendance : $e');
      return false;
    }
  }

  Future<Map<String, List<AttendanceModel>>> getAttendancesGroupedByDate(
      String lessonId) async {
    final Map<String, List<AttendanceModel>> groupedAttendances = {};

    try {
      final datesSnapshot = await _attendancesReference.get();

      for (final dateDoc in datesSnapshot.docs) {
        final dateId = dateDoc.id;

        // Bu tarihte bu derse ait yoklama alınmış mı?
        final lessonCollectionRef =
            _attendancesReference.doc(dateId).collection(lessonId);

        final lessonSnapshot = await lessonCollectionRef.get();

        // Eğer bu tarihte ders yoklaması varsa
        if (lessonSnapshot.docs.isNotEmpty) {
          List<AttendanceModel> students = lessonSnapshot.docs.map((doc) {
            final data = doc.data();
            return AttendanceModel().fromJson({
              ...data,
              'attendanceDate': dateId, // opsiyonel
            });
          }).toList();

          groupedAttendances[dateId] = students;
        }
      }

      return groupedAttendances;
    } catch (e) {
      _logger.e('Error fetching grouped attendances for lesson $lessonId: $e');
      return {};
    }
  }

  Future<List<AttendanceModel?>> getLessonPastAttendances(
      {required String lessonId, required String date}) async {
    try {
      final responseAttendance = await _attendancesReference
          .doc(date)
          .collection(lessonId)
          .withConverter(
            fromFirestore: (snapshot, _) {
              return AttendanceModel().fromFirebase(snapshot);
            },
            toFirestore: (value, _) => {},
          )
          .get();

      final attendanceData =
          responseAttendance.docs.map((doc) => doc.data()).toList();
      return attendanceData;
    } catch (e) {
      _logger.e('Error fetching student attendances: $e');
      return [];
    }
  }

  Future<void> increaseStudentAttendance({
    required String studentId,
    required String lessonId,
  }) async {
    try {
      final attendanceRef = FirebaseFirestore.instance
          .collection('students')
          .doc(studentId)
          .collection('lessonAttendances')
          .doc(lessonId);

      await attendanceRef.set({
        'attendedCount': FieldValue.increment(1),
      }, SetOptions(merge: true));
    } catch (e) {
      _logger.e('Error increasing student attendance: $e');
    }
  }

  Future<void> openAttendanceIfFirstToday(String lessonId) async {
    final lessonDoc =
        FirebaseFirestore.instance.collection('lessons').doc(lessonId);
    await lessonDoc.set({
      'totalAttendanceCount': FieldValue.increment(1),
    }, SetOptions(merge: true));
  }

  Future<List<AttendanceModel?>> getStudentPastAttendances(
      {required String lessonId, required String studentId}) async {
    try {
      final responseDates =
          await _studentsReference.doc(studentId).collection('pastPolls').get();

      List<AttendanceModel?> attendanceList = [];
      for (var attendance in responseDates.docs) {
        final responseAttendance = await _studentsReference
            .doc(studentId)
            .collection('pastPolls')
            .doc(attendance.id)
            .collection(lessonId)
            .doc(lessonId)
            .withConverter(
              fromFirestore: (snapshot, _) {
                return AttendanceModel().fromFirebase(snapshot);
              },
              toFirestore: (value, _) => {},
            )
            .get();
        if (responseAttendance.data() != null)
          attendanceList.add(responseAttendance.data());
      }
      return attendanceList;
    } catch (e) {
      _logger.e('Error fetching student attendances: $e');
      return [];
    }
  }

  Future<double?> getStudentPastAttendancesCount(
      {required String lessonId, required String studentId}) async {
    try {
      final responseAttendance = await _studentsReference
          .doc(studentId)
          .collection('lessonAttendances')
          .doc(lessonId)
          .get();
      final lessonModel = await _lessonsCollection
          .doc(lessonId)
          .withConverter(
            fromFirestore: (snapshot, _) {
              return LessonModel().fromFirebase(snapshot);
            },
            toFirestore: (value, _) => {},
          )
          .get();
      if (responseAttendance.data()?['attendedCount'] != null &&
          lessonModel.data()?.totalAttendanceCount != null)
        return (responseAttendance.data()?['attendedCount'] ?? 0) /
                lessonModel.data()?.totalAttendanceCount ??
            0;
    } catch (e) {
      _logger.e('Error fetching student attendances: $e');
      return null;
    }
  }
}
