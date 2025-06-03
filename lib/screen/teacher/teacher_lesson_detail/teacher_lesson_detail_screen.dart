import 'package:qr_attendance_project/export.dart';
import 'components/katilim_durumu_widget.dart';

///TODO: yarın bi dene  _OgretmenDersDetayState
class TeacherLessonDetailScreen extends StatefulWidget {
  const TeacherLessonDetailScreen({super.key, required this.lessonModel});
  final LessonModel lessonModel;

  @override
  State<TeacherLessonDetailScreen> createState() =>
      _TeacherLessonDetailScreenState();
}

class _TeacherLessonDetailScreenState extends State<TeacherLessonDetailScreen>
    with NavigatorManager, IconCreater {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context, title: LocaleKeys.appTitle.locale),
      body: Padding(
        padding: WidgetSizes.normalPadding.value,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: LessonInfo(
                lessonModel: widget.lessonModel,
              ),
            ),
            EmptyWidget(),
            Expanded(
              child: TeacherButton(
                lessonName: widget.lessonModel.lessonName!,
                lessonId: widget.lessonModel.lessonId!,
                startAttendance: () => navigateToNormalWidget(
                  context,
                  QrGeneratorScreen(
                    lessonModel: widget.lessonModel,
                  ),
                ),
              ),
            ),
            EmptyWidget(),
            Expanded(
              child: katilimDurumu('2025-05-19',
                  lessonName: widget.lessonModel.lessonName!,
                  lessonId: widget.lessonModel.lessonId!),
            )
          ],
        ),
      ),
    );
  }
}
