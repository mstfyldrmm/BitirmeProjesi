import 'package:qr_attendance_project/export.dart';

class StudentRequestView extends ChangeNotifier {
  ValueNotifier<List<RequestModel?>> requestList = ValueNotifier([]);
  ValueNotifier<List<RequestModel?>> requestFilteredList = ValueNotifier([]);
  ValueNotifier<bool> requestState = ValueNotifier(false);
  ValueNotifier<int> requestType = ValueNotifier(0);
  ValueNotifier<bool> dataLoading = ValueNotifier(true);

  Future<List<RequestModel?>> getRequestList(String userId) async {
    final data = await StudentService().fetchStudentRequests(userId);
    requestList.value = data;
    requestFilteredList.value = requestList.value;
    dataLoading.value = false;
    return requestList.value;
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
      requestFilteredList.value = requestList.value.where((request) {
        return request?.requestState == requestState.value;
      }).toList();
    } else if (requestType.value != 0 && requestState.value == false) {
      // Filter by request type only
      requestFilteredList.value = requestList.value.where((request) {
        return request?.requestType == requestType.value &&
            request?.requestState == (requestState.value);
      }).toList();
    } else if (requestType.value == 0 && requestState.value) {
      // Filter by request state only
      requestFilteredList.value = requestList.value.where((request) {
        return request?.requestState == requestState.value;
      }).toList();
    } else {
      requestFilteredList.value = requestList.value.where((request) {
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

  // void searchRequest(String query) {
  //   if (query.isEmpty) {
  //     requestFilteredList.value = requestList.value;
  //   } else {
  //     final lowerQuery = query.toLowerCase();
  //     requestFilteredList.value = requestList.value.where((request) {
  //       final type = request?.requestType?.toLowerCase() ?? '';

  //       return type.contains(lowerQuery);
  //     }).toList();
  //   }
  // }
}
