import 'package:qr_attendance_project/export.dart';
import 'package:qr_attendance_project/screen/teacher/teacher_lesson_detail/components/attendance_shimmer_widget.dart';
import 'package:qr_attendance_project/screen/teacher/teacher_lesson_detail/teacher_lesson_detail_view.dart';
import 'components/lesson_attendance_analysis.dart';

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
  late final TeacherLessonDetailView view;
  late final Future<Map<String, int>> _dataFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    view = TeacherLessonDetailView();
    _dataFuture = view.fetchLessonAllAttendancesCount(
        lessonId: widget.lessonModel.lessonId!);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
            ValueListenableBuilder(
                valueListenable: view.attendanceCount,
                builder: (_, __, ___) {
                  return Expanded(
                      child: FutureBuilder(
                          future: _dataFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return AttendanceShimmerWidget(
                                height: height,
                                width: width,
                              );
                            } else {
                              return LessonAttendanceAnalysis(
                                  attendanceAnalysis:
                                      view.attendanceCount.value,
                                  lessonId: widget.lessonModel.lessonId!,
                                  lessonName: widget.lessonModel.lessonName!);
                            }
                          }));
                })
          ],
        ),
      ),
    );
  }
}
