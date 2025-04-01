import 'package:qr_attendance_project/export.dart';


class TeacherMainScreen extends StatefulWidget {
  TeacherMainScreen({super.key, this.teacherId});
  String? teacherId;

  @override
  State<TeacherMainScreen> createState() => _TeacherMainScreenState();
}

class _TeacherMainScreenState extends State<TeacherMainScreen>
    with NavigatorManager, IconCreater {
  late final TeacherMainView _vm;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _vm = TeacherMainView();
    _vm.getTeacherLessons(widget.teacherId!);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: WidgetSizes.normalPadding.value,
        child: Column(
          children: [
            Text(widget.teacherId ?? ''),
            CustomTextField(
              title: LocaleKeys.studentMain_lessonsSearch.locale,
              icon: Icon(Icons.search),
              controller: searchController,
            ),
            TeacherLessonCreater(dersler: _vm.teacherLesson.value),
          ],
        ),
      ),
      floatingActionButton: TeacherFabWidget(),
    );
  }
}
