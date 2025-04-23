import 'package:qr_attendance_project/export.dart';

class StudentRequestView extends ChangeNotifier {
  ValueNotifier<List<RequestModel?>> requestList = ValueNotifier([]);

  Future<List<RequestModel?>> getRequestList(String userId) async {
    requestList.value = await StudentService().fetchStudentRequests(userId);
    return requestList.value;
  }
}
