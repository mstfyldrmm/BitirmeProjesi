import 'package:qr_attendance_project/export.dart';
import 'package:qr_attendance_project/screen/qr/qr_scanner/qr_scanner_screen.dart';

class StudentLessonDetailScreen extends StatefulWidget with IconCreater {
  final LessonModel lessonModel;
  final StudentModel studentModel;

  const StudentLessonDetailScreen({
    super.key,
    required this.lessonModel,
    required this.studentModel,
  });

  @override
  State<StudentLessonDetailScreen> createState() =>
      _StudentLessonDetailScreenState();
}

class _StudentLessonDetailScreenState extends State<StudentLessonDetailScreen>
    with NavigatorManager {
  @override
  Widget build(BuildContext context) {
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
              child: PageView(
                scrollDirection: Axis.horizontal,
                children: [
                  AttendanceInfoWidget(
                    onTapQrScanner: () {
                      navigateToNormalWidget(
                        context,
                        QrScannerScreen(
                          lessonModel: widget.lessonModel,
                          studentModel: widget.studentModel,
                        ),
                      );
                    },
                  ),
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
