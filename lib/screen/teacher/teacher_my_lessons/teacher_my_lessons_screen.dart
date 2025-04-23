import 'package:qr_attendance_project/export.dart';

class TeacherMyLessons extends StatefulWidget {
  TeacherMyLessons({super.key, this.teacherId});
  String? teacherId;

  @override
  State<TeacherMyLessons> createState() => _TeacherMyLessonsState();
}

class _TeacherMyLessonsState extends State<TeacherMyLessons>
    with NavigatorManager, IconCreater {
  late final TeacherMyLessonsView _vm;

  @override
  void initState() {
    super.initState();
    _vm = TeacherMyLessonsView();
    _vm.getTeacherLessons(widget.teacherId!);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _vm.getTeacherLessons(widget.teacherId!),
        child: Padding(
          padding: WidgetSizes.normalPadding.value,
          child: ValueListenableBuilder(
              valueListenable: _vm.teacherLessons,
              builder: (_, __, ___) {
                return _vm.teacherLessons.value.isNotEmpty
                    ? Column(
                        children: [
                          CustomTextField(
                            title: LocaleKeys.studentMain_lessonsSearch.locale,
                            icon: Icon(Icons.search),
                            controller: searchController,
                            onChanged: (String text) {
                              _vm.filterLessons(text);
                            },
                          ),
                          ValueListenableBuilder(
                            valueListenable: _vm.teacherFilteredLessons,
                            builder: (_, __, ___) {
                              return TeacherLessonItem(
                                lesson: _vm.teacherFilteredLessons.value,
                                onPressAction: (lesson) =>
                                    _vm.deleteTeacherLesson(lesson),
                                onPressDismissed: (lesson) =>
                                    _vm.deleteTeacherLesson(lesson),
                              );
                            },
                          ),
                        ],
                      )
                    : CustomEmptyDataWidget(
                        imagePath: 'assets/icons/sleep.png',
                        title: LocaleKeys
                            .studentMain_studentEmptyLessonMessage.locale,
                      );
              }),
        ),
      ),
      floatingActionButton: TeacherFabWidget(
        teacherId: widget.teacherId!,
      ),
    );
  }
}
