import 'package:qr_attendance_project/export.dart';

class StudentRequestScreen extends StatefulWidget {
  const StudentRequestScreen({super.key, this.userId});
  final String? userId;

  @override
  State<StudentRequestScreen> createState() => _StudentRequestScreenState();
}

class _StudentRequestScreenState extends State<StudentRequestScreen>
    with IconCreater, NavigatorManager {
  late final StudentRequestView vm;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vm = StudentRequestView();
    vm.getRequestList(widget.userId!);
  }

  @override
  Widget build(BuildContext context) {
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
                return Column(
                  children: vm.requestList.value.isEmpty
                      ? [
                          Center(
                            child: CustomEmptyDataWidget(
                              emptySize: 80,
                              title: LocaleKeys
                                  .studentRequest_dontHaveRequest.locale,
                              imagePath: 'assets/icons/sleepp.png',
                            ),
                          )
                        ]
                      : [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 50),
                                      child: Text(
                                        'Tüm istekler Gösteriliyor',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 80),
                                      child: CustomIconCreator(
                                        iconPath: 'assets/icons/filter.png',
                                        iconSize: 40,
                                        iconColor: Theme.of(context)
                                            .hintColor
                                            .withValues(
                                              alpha: 1,
                                            ),
                                      ),
                                    ),
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
                                    itemCount: vm.requestList.value.length,
                                    itemBuilder: (context, index) {
                                      return RequestCardWidget(
                                        requestModel:
                                            vm.requestList.value[index]!,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                );
              },
              valueListenable: vm.requestList),
        ),
      ),
    );
  }
}
