import 'package:qr_attendance_project/export.dart';
import 'package:qr_attendance_project/screen/teacher/teacher_request/companents/teacher_request_card_widget.dart';
import 'package:qr_attendance_project/screen/teacher/teacher_request/teacher_request_view.dart';
import 'package:qr_attendance_project/screen/widgets/filter_bottom_sheet_widget.dart';
import 'package:qr_attendance_project/screen/widgets/shimmer_request_widget.dart';

class TeacherRequestScreen extends StatefulWidget {
  const TeacherRequestScreen({super.key, required this.teacherId});
  final String? teacherId;

  @override
  State<TeacherRequestScreen> createState() => _TeacherRequestScreenState();
}

class _TeacherRequestScreenState extends State<TeacherRequestScreen> {
  late final TeacherRequestView vm;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vm = TeacherRequestView();
    vm.getRequests(widget.teacherId!);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: WidgetSizes.normalPadding.value,
        child: ValueListenableBuilder(
          valueListenable: vm.teacherRequestsNotifierFiltered,
          builder: (context, value, child) {
            return RefreshIndicator(
              onRefresh: () => vm.getRequests(widget.teacherId!),
              child: Column(
                children: vm.teacherRequestsNotifier.value.isEmpty
                    ? [
                        ValueListenableBuilder(
                            valueListenable: vm.dataLoading,
                            builder: (_, __, ___) {
                              return vm.dataLoading.value
                                  ? ShimmerRequestWidget()
                                  : Center(
                                      child: CustomEmptyDataWidget(
                                        emptySize: 70,
                                        title: LocaleKeys
                                            .studentRequest_teacherdontHaveRequest
                                            .locale,
                                        imagePath: 'assets/icons/sleepp.png',
                                      ),
                                    );
                            })
                      ]
                    : [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: width * 0.75,
                              child: CustomTextField(
                                controller: searchController,
                                icon: Icon(
                                  Icons.search_outlined,
                                ),
                                title: 'Search Request',
                                onChanged: (value) {},
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  vm.showModalBottomSheetFunction(
                                      context,
                                      ValueListenableBuilder(
                                          valueListenable: vm.requestState,
                                          builder: (_, __, ___) {
                                            return ValueListenableBuilder(
                                              valueListenable: vm.requestState,
                                              builder:
                                                  (_, requestStateValue, __) {
                                                return ValueListenableBuilder(
                                                  valueListenable:
                                                      vm.requestType,
                                                  builder: (_, requestTypeValue,
                                                      __) {
                                                    return FilterBottomSheetWidget(
                                                      requestType: requestTypeValue ==
                                                              0
                                                          ? ""
                                                          : requestTypeValue ==
                                                                  1
                                                              ? LocaleKeys
                                                                  .studentRequest_requestTypeOne
                                                                  .locale
                                                              : LocaleKeys
                                                                  .studentRequest_requestTypeTwo
                                                                  .locale,
                                                      requestState:
                                                          requestStateValue
                                                              ? "true"
                                                              : "false",
                                                      stateChange: vm
                                                          .changeRadioButtonValue,
                                                      onPressed: () {
                                                        vm.filterRequest();
                                                        Navigator.pop(
                                                            _); // veya context kullanabilirsin
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                          }));
                                },
                                icon: Icon(
                                  Icons.filter_alt_rounded,
                                ))
                          ],
                        ),
                        EmptyWidget(),
                        Expanded(
                            child: ListView.separated(
                                itemBuilder: (BuildContext context, int index) {
                                  return TeacherRequestCardWidget(
                                    solveProblemFunction: () {
                                      vm.solveProblem(
                                        vm.teacherRequestsNotifierFiltered
                                            .value[index]!,
                                      );
                                    },
                                    studentInfo: vm.studentsName.value,
                                    requestModel: vm
                                        .teacherRequestsNotifierFiltered
                                        .value[index]!,
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return EmptyWidget(
                                    height: 15,
                                  );
                                },
                                itemCount: vm.teacherRequestsNotifierFiltered
                                    .value.length))
                      ],
              ),
            );
          },
        ),
      ),
    );
  }
}
