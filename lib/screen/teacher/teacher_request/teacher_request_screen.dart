import 'package:qr_attendance_project/export.dart';
import 'package:qr_attendance_project/screen/teacher/teacher_request/companents/teacher_request_card_widget.dart';
import 'package:qr_attendance_project/screen/teacher/teacher_request/teacher_request_view.dart';

class TeacherRequestScreen extends StatefulWidget {
  const TeacherRequestScreen({super.key, required this.teacherId});
  final String? teacherId;

  @override
  State<TeacherRequestScreen> createState() => _TeacherRequestScreenState();
}

class _TeacherRequestScreenState extends State<TeacherRequestScreen> {
  late final TeacherRequestView vm;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vm = TeacherRequestView();
    vm.getRequests(widget.teacherId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: WidgetSizes.normalPadding.value,
        child: ValueListenableBuilder(
          valueListenable: vm.teacherRequestsNotifier,
          builder: (context, value, child) {
            return RefreshIndicator(
              onRefresh: () => vm.getRequests(widget.teacherId!),
              child: Column(
                children: vm.teacherRequestsNotifier.value.isEmpty
                    ? [
                        Center(
                          child: CustomEmptyDataWidget(
                            emptySize: 70,
                            title: LocaleKeys
                                .studentRequest_teacherdontHaveRequest.locale,
                            imagePath: 'assets/icons/sleepp.png',
                          ),
                        )
                      ]
                    : [
                        Expanded(
                            child: ListView.separated(
                                itemBuilder: (BuildContext context, int index) {
                                  return TeacherRequestCardWidget(
                                    solveProblemFunction: () {
                                      vm.solveProblem(
                                        vm.teacherRequestsNotifier
                                            .value[index]!,
                                      );
                                    },
                                    studentInfo: vm.studentsName.value,
                                    requestModel: vm
                                        .teacherRequestsNotifier.value[index]!,
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return EmptyWidget(
                                    height: 15,
                                  );
                                },
                                itemCount:
                                    vm.teacherRequestsNotifier.value.length))
                      ],
              ),
            );
          },
        ),
      ),
    );
  }
}
