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
    // TODO: implement initState
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
          child: Column(
            children: [
              CustomTextField(
                title: LocaleKeys.studentMain_lessonsSearch.locale,
                icon: Icon(Icons.search),
                controller: searchController,
              ),
              ValueListenableBuilder(
                  valueListenable: _vm.teacherLesson,
                  builder: (_, __, ___) {
                    return TeacherLessonCreater(
                        vm: _vm,
                        dersler: _vm.teacherLesson.value);
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: TeacherFabWidget(
        teacherId: widget.teacherId!,
      ),
    );
  }
}
