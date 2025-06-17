import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:qr_attendance_project/export.dart';

class TeacherRequestView extends ChangeNotifier {
  ValueNotifier<List<RequestModel?>> teacherRequestsNotifier =
      ValueNotifier([]);
  ValueNotifier<List<RequestModel?>> teacherRequestsNotifierFiltered =
      ValueNotifier([]);
  ValueNotifier<StudentModel?> studentModel = ValueNotifier(null);
  ValueNotifier<LessonModel?> requestLessonData = ValueNotifier(null);
  ValueNotifier<bool> requestState = ValueNotifier(false);
  ValueNotifier<String> requestStateText =
      ValueNotifier(LocaleKeys.studentRequest_allRequests.locale);
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

  Future<StudentModel?> getStudentInfo(String studentId) async {
    final data = await StudentService().fetchStudent(studentId);
    studentModel.value = data;
    return studentModel.value;
  }

  String formatTime(DateTime dateTime) {
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  Future<bool> takeAttendance({
    required AttendanceModel attendanceModel,
    required String lessonClass,
  }) async {
    return await AttendanceService().solvedStudentAttendance(
      lessonClass: lessonClass,
      attendanceModel: attendanceModel,
    );
  }

  Future<void> solveProblem(RequestModel request) async {
    bool isCheck = request.requestState!;
    if (isCheck) {
    } else {
      if (request.requestType! == 1) {
        bool isRegisterOkey = await StudentService()
            .addLessonStudent(request.requestStudentId!, request.requestLessonId!);
        if (isRegisterOkey) {
          showToast(
              '${request.requestStudentId} ${request.requestLesson} ${LocaleKeys.studentRequest_lessonRegisterSolved.locale}',
              isError: false);
          TeacherService().updateRequestState(request.requestId!);
        }
      } else {
        requestLessonData.value = await TeacherService().fetchLessonInfo(
          request.requestLessonId!,
        );
        studentModel.value = await getStudentInfo(
          request.requestStudentId!,
        );
        final DateTime now = DateTime.now();
        final String createdTime = DateFormat('HH:mm:ss').format(now);
        final String microsecondData = now.microsecondsSinceEpoch.toString();
        bool registerAttendanceState = await takeAttendance(
            attendanceModel: AttendanceModel(
              studentId: request.requestStudentId!,
              schoolNumber: studentModel.value?.schoolNumber ?? 0,
              studentName: studentModel.value?.studentName ?? '',
              studentSurname: studentModel.value?.studentSurname ?? '',
              attendanceLessonId: request.requestLessonId!,
              qrAttendanceClass:
                  int.parse(requestLessonData.value?.classLevel ?? '1'),
              createdDate: Timestamp.fromDate(now),
              qrCodeData:
                  "${requestLessonData.value?.lessonCode ?? ''}-${request.requestAttendanceDate}-$createdTime-$microsecondData",
              qrAttendanceId:
                  "${request.requestLessonId}-${request.requestStudentId}-${request.requestAttendanceDate}",
            ),
            lessonClass: requestLessonData.value?.classLevel ?? '1');
        if (registerAttendanceState) {
          showToast(
              '${request.requestStudentId}  ${request.requestLesson} ${LocaleKeys.studentRequest_attendanceSolved.locale}',
              isError: false);
          TeacherService().updateRequestState(request.requestId!);
        } else {
          showToast(
              '${request.requestStudentId}  ${request.requestLesson} ${LocaleKeys.errorCode_request_attendanceRequestFailed.locale}',
              isError: true);
        }
      }
    }
  }

  String createShowingFilterText() {
    String typeOne = LocaleKeys.studentRequest_requestTypeOne.locale;
    String typeTwo = LocaleKeys.studentRequest_requestTypeTwo.locale;
    requestType.value == 0
        ? requestStateText.value = LocaleKeys.studentRequest_allRequests.locale
        : requestType.value == 1
            ? requestStateText.value = typeOne
            : requestStateText.value = typeTwo;
    requestState.value
        ? "${requestStateText.value} - ${LocaleKeys.studentRequest_stateOne.locale}"
        : "${requestStateText.value} - ${LocaleKeys.studentRequest_stateTwo.locale}";
    return requestStateText.value;
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
    createShowingFilterText();
    if (requestType.value == 0 && requestState.value == false) {
      teacherRequestsNotifierFiltered.value =
          teacherRequestsNotifier.value.where((request) {
        return request?.requestState == requestState.value;
      }).toList();
    } else if (requestType.value != 0 && requestState.value == false) {
      // Filter by request type only
      teacherRequestsNotifierFiltered.value =
          teacherRequestsNotifier.value.where((request) {
        return request?.requestType == requestType.value &&
            request?.requestState == (requestState.value);
      }).toList();
    } else if (requestType.value == 0 && requestState.value) {
      // Filter by request state only
      teacherRequestsNotifierFiltered.value =
          teacherRequestsNotifier.value.where((request) {
        return request?.requestState == requestState.value;
      }).toList();
    } else {
      teacherRequestsNotifierFiltered.value =
          teacherRequestsNotifier.value.where((request) {
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
