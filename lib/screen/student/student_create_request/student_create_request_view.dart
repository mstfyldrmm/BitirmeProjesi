import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_attendance_project/export.dart';

class StudentCreateRequestView extends ChangeNotifier {
  ValueNotifier<List<TeacherModel>> teachers = ValueNotifier([]);
  ValueNotifier<List<String?>> teacherLessons = ValueNotifier([]);
  ValueNotifier<String> teacherId = ValueNotifier('');
  ValueNotifier<String> teacherName = ValueNotifier('');
  ValueNotifier<String> requestLesson = ValueNotifier('');
  ValueNotifier<String> requestDescription = ValueNotifier('');
  ValueNotifier<String?> requestId = ValueNotifier('');
  ValueNotifier<String?> requestType = ValueNotifier('');

  Future<void> getAllTeacher() async {
    teachers.value = await TeacherService().fetchAllTeachers();
  }

  Future<void> getLessonsTeacher(String teacherId) async {
    final data = await TeacherService().fetchTeacherLessons(teacherId);
    teacherLessons.value = data.map((e) => e?.lessonName).toList();
  }

  Future<void> createRequestPersons(
    String studentId,
    String teacherId,
  ) async {
    requestId.value = await StudentService().addRequestFirebase(
      RequestModel(
        requestDescription: requestDescription.value,
        requestDate: Timestamp.now(),
        requestId: requestId.value,
        requestStudentId: studentId,
        requestLesson: requestLesson.value,
        requestState: false,
        requestType:
            requestType.value == LocaleKeys.studentRequest_requestTypeOne.locale
                ? 1
                : 2, // 1 for registration, 2 for attendance
      ),
    );
    await StudentService().addRequestsStudent(studentId, requestId.value!);
    await TeacherService().addRequestTeacher(teacherId, requestId.value!);
  }

  String? validateTextField(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validate_noEmpty.locale;
    }
    return null;
  }
}
