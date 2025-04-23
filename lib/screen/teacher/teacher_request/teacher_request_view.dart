import 'package:qr_attendance_project/export.dart';

class TeacherRequestView extends ChangeNotifier {
  ValueNotifier<List<RequestModel?>> teacherRequestsNotifier =
      ValueNotifier([]);
  ValueNotifier<String> studentsName = ValueNotifier('');

  final _logger = Logger(printer: PrettyPrinter());

  Future<List<RequestModel?>> getRequests(String teacherId) async {
    teacherRequestsNotifier.value =
        await TeacherService().fetchTeacherRequests(teacherId);
    return teacherRequestsNotifier.value;
  }

  Future<void> getStudentInfo(String studentId) async {
    final data = await StudentService().fetchStudent(studentId);
    studentsName.value = "${data?.studentName} ${data?.studentSurname}";
  }

  String formatTime(DateTime dateTime) {
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  Future<void> solveProblem(RequestModel request) async {
    bool isCheck = request.requestState!;
    if (isCheck) {
    } else {
      if (request.requestType!.toLowerCase() == "ders kayıt talebi" ||
          request.requestType!.toLowerCase() == "course registration request") {
        bool isRegisterOkey = await StudentService()
            .addLessonStudent(request.requestStudentId!, request.requestId!);
        if (isRegisterOkey) {
          showToast(
              '${request.requestStudentId} öğrencisinin ${request.requestLesson} dersine kaydı başarılı bir şekilde tamamlandı',
              isError: false);
          TeacherService().updateRequestState(request.requestId!);
        }
      } else {}
    }
  }
}
