import 'package:qr_attendance_project/export.dart';
import 'package:qr_attendance_project/screen/widgets/lesson_info.dart';
import 'package:qr_attendance_project/screen/teacher/teacher_lesson_detail/components/teacher_button.dart';
import 'components/katilim_durumu_widget.dart';

class TeacherLessonDetailScreen extends StatefulWidget {
  const TeacherLessonDetailScreen({super.key, required this.lessonModel});
  final LessonModel lessonModel;

  @override
  State<TeacherLessonDetailScreen> createState() => _OgretmenDersDetayState();
}

class _OgretmenDersDetayState extends State<TeacherLessonDetailScreen>
    with NavigatorManager, IconCreater {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context, title: 'Ders Adi'),
      body: Padding(
        padding: WidgetSizes.normalPadding.value,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                flex: 2,
                child: LessonInfo(
                  lessonModel: widget.lessonModel,
                )),
            Expanded(flex: 2, child: TeacherButton()),
            Expanded(flex: 2, child: katilimDurumu('as'))
          ],
        ),
      ),
    );
  }
}
