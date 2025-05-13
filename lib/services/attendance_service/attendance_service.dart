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
      final collectionReference = _getCollectionReference(lessonClass);

      await collectionReference.doc(qrAttendanceModel.qrAttendanceId).set(
            qrAttendanceModel.toJson(),
          );

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

  Future<List<String>> getAttendanceDates() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collectionGroup('attendances').get();

      final dates = querySnapshot.docs.map((doc) => doc.id).toList();
      return dates;
    } catch (e) {
      _logger.e('Error fetching attendance dates: $e');
      return [];
    }
  }

  Future<List<AttendanceModel?>> getStudentAttendances(
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
}
