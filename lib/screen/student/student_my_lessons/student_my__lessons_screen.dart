import 'package:qr_attendance_project/export.dart';


class StudentMyLessonsScreen extends StatefulWidget {
  StudentMyLessonsScreen({super.key, this.userId});
  String? userId;

  @override
  State<StudentMyLessonsScreen> createState() => _StudentMyLessonsScreenState();
}

class _StudentMyLessonsScreenState extends State<StudentMyLessonsScreen>
    with NavigatorManager, IconCreater {
  late final StudentMyLessonsView _vm;

  @override
  void initState() {
    _vm = StudentMyLessonsView();
    _vm.getLessons(widget.userId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: WidgetSizes.normalPadding.value,
        child: Column(
          children: [
            CustomTextField(
              title: LocaleKeys.studentMain_lessonsSearch.locale,
              icon: Icon(Icons.search),
              controller: searchController,
            ),
            SizedBox(height: 20),
            ValueListenableBuilder(
              valueListenable: _vm.studentLessonsNotifier,
              builder: (_, __, ___) {
                return (_vm.studentLessonsNotifier.value.isNotEmpty)
                    ? Expanded(
                        child: ListView.separated(
                          itemCount: _vm.studentLessonsNotifier.value.length,
                          itemBuilder: (BuildContext context, int index) {
                            return StudentLessonCard(
                              context: context,
                              iconAddress: 'assets/icons/chalkboard.png',
                              lessonModel:
                                  _vm.studentLessonsNotifier.value[index],
                              onTapLessonCard: () {
                                navigateToWidget(
                                  context,
                                  StudentLessonDetailScreen(),
                                );
                              },
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: 20,
                          ),
                        ),
                      )
                    : LessonsEmptyWidget();
              },
            ),
          ],
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
