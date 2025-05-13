import 'package:qr_attendance_project/export.dart';
import 'package:qr_attendance_project/screen/widgets/shimmer_list_widget.dart';

class StudentMyLessonsScreen extends StatefulWidget {
  StudentMyLessonsScreen({super.key, this.userId});
  String? userId;

  @override
  State<StudentMyLessonsScreen> createState() => _StudentMyLessonsScreenState();
}

class _StudentMyLessonsScreenState extends State<StudentMyLessonsScreen>
    with NavigatorManager, IconCreater {
  late final StudentMyLessonsView _vm;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _vm = StudentMyLessonsView();
    _vm.getLessons(widget.userId!);
    _vm.getCurrentStudent(widget.userId!);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _vm.getLessons(widget.userId!),
        child: Padding(
          padding: WidgetSizes.normalPadding.value,
          child: ValueListenableBuilder(
              valueListenable: _vm.isLoading,
              builder: (_, __, ___) {
                return (_vm.isLoading.value)
                    ? ShimmerListWidget()
                    : ValueListenableBuilder(
                        valueListenable: _vm.studentLessonsNotifier,
                        builder: (_, __, ___) {
                          return (_vm.studentLessonsNotifier.value.isNotEmpty)
                              ? Column(
                                  children: [
                                    CustomTextField(
                                      title: LocaleKeys
                                          .studentMain_lessonsSearch.locale,
                                      icon: Icon(Icons.search),
                                      controller: _searchController,
                                      onChanged: (String text) {
                                        _vm.filterLessons(text);
                                      },
                                    ),
                                    SizedBox(height: 20),
                                    ValueListenableBuilder(
                                      valueListenable:
                                          _vm.studentFilteredLessonsNotifier,
                                      builder: (_, __, ___) {
                                        return Expanded(
                                          child: ListView.separated(
                                            shrinkWrap: true,
                                            itemCount: _vm
                                                .studentFilteredLessonsNotifier
                                                .value
                                                .length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return StudentLessonCard(
                                                context: context,
                                                iconAddress:
                                                    'assets/icons/chalkboard.png',
                                                lessonModel: _vm
                                                    .studentFilteredLessonsNotifier
                                                    .value[index],
                                                onTapLessonCard: () {
                                                  navigateToWidget(
                                                    context,
                                                    StudentLessonDetailScreen(
                                                      lessonModel: _vm
                                                          .studentFilteredLessonsNotifier
                                                          .value[index]!,
                                                      studentModel: _vm
                                                          .studentNotifier
                                                          .value!,
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            separatorBuilder:
                                                (context, index) => SizedBox(
                                              height: 20,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                )
                              : LessonsEmptyWidget();
                        });
              }),
        ),
      ),
      /*
      floatingActionButton: FabMenu(
        isExpanded: _isExpanded,
      ),
       */
    );
  }
}
