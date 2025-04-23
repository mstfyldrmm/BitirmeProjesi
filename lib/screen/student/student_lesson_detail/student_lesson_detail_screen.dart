import 'package:qr_attendance_project/export.dart';

class StudentLessonDetailScreen extends StatefulWidget with IconCreater {
  const StudentLessonDetailScreen({super.key, required this.lessonModel});
  final LessonModel lessonModel;

  @override
  State<StudentLessonDetailScreen> createState() =>
      _StudentLessonDetailScreenState();
}

class _StudentLessonDetailScreenState extends State<StudentLessonDetailScreen> {
  @override
  Widget build(BuildContext context) {
    bool isAttendanceAvailable = false;

    return Scaffold(
      appBar: CustomAppBar(context,
          title: LocaleKeys.studentLessonDetail_title.locale),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: LessonInfo(
                  lessonModel: widget.lessonModel,
                )),
            EmptyWidget(),
            Expanded(
              flex: 2,
              child: isAttendanceAvailable
                  ? JoinAttendanceButtonWidget(context)
                  : PageView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        AttendanceInfoWidget(),
                        AttendanceHistoryWidget(),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
