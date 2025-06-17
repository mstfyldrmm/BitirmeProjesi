import 'package:qr_attendance_project/export.dart';
import 'package:qr_attendance_project/screen/widgets/filter_bottom_sheet_widget.dart';
import 'package:qr_attendance_project/screen/widgets/shimmer_request_widget.dart';

class StudentRequestScreen extends StatefulWidget {
  const StudentRequestScreen({super.key, this.userId});
  final String? userId;

  @override
  State<StudentRequestScreen> createState() => _StudentRequestScreenState();
}

class _StudentRequestScreenState extends State<StudentRequestScreen>
    with IconCreater, NavigatorManager {
  late final StudentRequestView vm;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vm = StudentRequestView();
    vm.getRequestList(widget.userId!);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToWidget(
              context,
              StudentCreateRequestScreen(
                userId: widget.userId,
              ));
        },
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: iconCreaterColor('assets/icons/clipboard.png', context),
      ),
      body: Padding(
        padding: WidgetSizes.normalPadding.value,
        child: RefreshIndicator(
          onRefresh: () => vm.getRequestList(widget.userId!),
          child: ValueListenableBuilder(
              builder: (context, value, child) {
                return vm.requestList.value.isNotEmpty
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ValueListenableBuilder(
                                valueListenable: vm.requestStateText,
                                builder: (_, requestStateTextValue, __) {
                                  return SizedBox(
                                      width: width * 0.75,
                                      height: width * 0.2,
                                      child: CustomCardWidget(
                                          paddingValue: 5,
                                          childWidget: Center(
                                            child: Text(
                                              "${vm.requestStateText.value} ${LocaleKeys.studentRequest_showing.locale}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                          )));
                                },
                              ),
                              IconButton(
                                  onPressed: () {
                                    vm.showModalBottomSheetFunction(
                                        context,
                                        ValueListenableBuilder(
                                            valueListenable: vm.requestState,
                                            builder: (_, __, ___) {
                                              return ValueListenableBuilder(
                                                valueListenable:
                                                    vm.requestState,
                                                builder:
                                                    (_, requestStateValue, __) {
                                                  return ValueListenableBuilder(
                                                    valueListenable:
                                                        vm.requestType,
                                                    builder: (_,
                                                        requestTypeValue, __) {
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
                                  icon: Icon(Icons.filter_1_outlined))
                            ],
                          ),
                          EmptyWidget(),
                          Expanded(
                            child: ListView.separated(
                              separatorBuilder: (context, index) {
                                return EmptyWidget(
                                  height: 20,
                                );
                              },
                              itemCount: vm.requestFilteredList.value.length,
                              itemBuilder: (context, index) {
                                return RequestCardWidget(
                                  requestModel:
                                      vm.requestFilteredList.value[index]!,
                                );
                              },
                            ),
                          )
                        ],
                      )
                    : ValueListenableBuilder(
                        valueListenable: vm.dataLoading,
                        builder: (_, __, ___) {
                          return vm.dataLoading.value
                              ? const ShimmerRequestWidget()
                              : Center(
                                  child: CustomEmptyDataWidget(
                                    emptySize: 80,
                                    title: LocaleKeys
                                        .studentRequest_dontHaveRequest.locale,
                                    imagePath: 'assets/icons/sleepp.png',
                                  ),
                                );
                        });
              },
              valueListenable: vm.requestFilteredList),
        ),
      ),
    );
  }
}
