import 'package:qr_attendance_project/export.dart';

class TeacherRequestView extends ChangeNotifier {
  ValueNotifier<List<RequestModel?>> teacherRequestsNotifier =
      ValueNotifier([]);
  ValueNotifier<List<RequestModel?>> teacherRequestsNotifierFiltered =
      ValueNotifier([]);
  ValueNotifier<String> studentsName = ValueNotifier('');
  ValueNotifier<bool> requestState = ValueNotifier(false);
  ValueNotifier<int> requestType = ValueNotifier(0);
  ValueNotifier<bool> dataLoading = ValueNotifier(true);

  final _logger = Logger(printer: PrettyPrinter());

  Future<List<RequestModel?>> getRequests(String teacherId) async {
    final data = await TeacherService().fetchTeacherRequests(teacherId);
    teacherRequestsNotifier.value = data;
    teacherRequestsNotifierFiltered.value = teacherRequestsNotifier.value;
    dataLoading.value = false;
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
      if (request.requestType! == 1) {
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

  void changeRadioButtonValue(String value) {
    String typeOne = LocaleKeys.studentRequest_requestTypeOne.locale;
    String typeTwo = LocaleKeys.studentRequest_requestTypeTwo.locale;
    if (typeOne.contains(value)) {
      requestType.value = 1;
    } else if (typeTwo.contains(value)) {
      requestType.value = 2;
    } else if (value == "false") {
      requestState.value = false; //false means waiting
    } else if (value == "true") {
      requestState.value = true; //true means completed
    }
  }

  void filterRequest() {
    if (requestType.value == 0 && requestState.value == false) {
      teacherRequestsNotifierFiltered.value = teacherRequestsNotifier.value.where((request) {
        return request?.requestState == requestState.value;
      }).toList();
    } else if (requestType.value != 0 && requestState.value == false) {
      // Filter by request type only
      teacherRequestsNotifierFiltered.value = teacherRequestsNotifier.value.where((request) {
        return request?.requestType == requestType.value &&
            request?.requestState == (requestState.value);
      }).toList();
    } else if (requestType.value == 0 && requestState.value) {
      // Filter by request state only
      teacherRequestsNotifierFiltered.value = teacherRequestsNotifier.value.where((request) {
        return request?.requestState == requestState.value;
      }).toList();
    } else {
      teacherRequestsNotifierFiltered.value = teacherRequestsNotifier.value.where((request) {
        return request?.requestType == requestType.value &&
            request?.requestState == (requestState.value);
      }).toList();
    }
  }

  void showModalBottomSheetFunction(BuildContext context, Widget child) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return child;
      },
    );
  }
}
