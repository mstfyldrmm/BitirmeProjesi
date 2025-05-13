import 'package:qr_attendance_project/export.dart';
import 'package:qr_attendance_project/screen/widgets/shimmer_list_widget.dart';

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
              valueListenable: _vm.isLoading,
              builder: (_, __, ___) {
                return (_vm.isLoading.value)
                    //shimmer efekt için kontrol
                    ? ShimmerListWidget()
                    : ValueListenableBuilder(
                        valueListenable: _vm.teacherLessons,
                        builder: (context, value, child) {
                          return _vm.teacherLessons.value.isEmpty
                              ? CustomEmptyDataWidget(
                                  imagePath: 'assets/icons/sleep.png',
                                  title: LocaleKeys
                                      .studentMain_studentEmptyLessonMessage
                                      .locale,
                                )
                              : Column(
                                  children: [
                                    CustomTextField(
                                      title: LocaleKeys
                                          .studentMain_lessonsSearch.locale,
                                      icon: Icon(Icons.search),
                                      controller: searchController,
                                      onChanged: (String text) {
                                        _vm.filterLessons(text);
                                      },
                                    ),
                                    ValueListenableBuilder(
                                      valueListenable:
                                          _vm.teacherFilteredLessons,
                                      builder: (_, __, ___) {
                                        return TeacherLessonItem(
                                          lesson:
                                              _vm.teacherFilteredLessons.value,
                                          onPressAction: (lesson) =>
                                              _vm.deleteTeacherLesson(lesson),
                                          onPressDismissed: (lesson) =>
                                              _vm.deleteTeacherLesson(lesson),
                                        );
                                      },
                                    ),
                                  ],
                                );
                        },
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
