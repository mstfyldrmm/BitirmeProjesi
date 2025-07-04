import 'package:geolocator/geolocator.dart';
import 'package:qr_attendance_project/export.dart';
import 'package:qr_attendance_project/screen/qr/qr_scanner/qr_scanner_screen.dart';
import 'package:qr_attendance_project/screen/student/student_lesson_detail/student_lesson_detail_view.dart';

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
  late final StudentsLessonDetailView _studentsLessonDetailView;
  late Future<Position?> _locationFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _studentsLessonDetailView = StudentsLessonDetailView();
    _studentsLessonDetailView.fetchStudentsAttendanceList(
      lessonId: widget.lessonModel.lessonId ?? '',
      studentId: widget.studentModel.studentId ?? '',
    );
    _studentsLessonDetailView.fetchStudentsAttendanceState(
      lessonId: widget.lessonModel.lessonId ?? '',
      studentId: widget.studentModel.studentId ?? '',
    );
    _locationFuture = _studentsLessonDetailView.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar(context,
          title: LocaleKeys.studentLessonDetail_title.locale),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height / 4,
                child: LessonInfo(
                  lessonModel: widget.lessonModel,
                ),
              ),
              EmptyWidget(),
              SizedBox(
                height: height * 0.6,
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ValueListenableBuilder(
                        valueListenable:
                            _studentsLessonDetailView.studentAttendancePercent,
                        builder: (_, value, ___) {
                          return FutureBuilder(
                              future: _locationFuture,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SizedBox(
                                    height:
                                        height, // Burada screenHeight senin mevcut yüksekliğin
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [

                                        Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return AttendanceInfoWidget(
                                    totalAttendanceCount: widget
                                            .lessonModel.totalAttendanceCount ??
                                        0,
                                    attendancePercentage:
                                        _studentsLessonDetailView
                                                .studentAttendancePercent
                                                .value ??
                                            0.0,
                                    onTapQrScanner: () {
                                      navigateToNormalWidget(
                                        context,
                                        QrScannerScreen(
                                          position: _studentsLessonDetailView
                                              .currentLocation.value,
                                          lessonModel: widget.lessonModel,
                                          studentModel: widget.studentModel,
                                        ),
                                      );
                                    },
                                  );
                                }
                              });
                        }),
                    ValueListenableBuilder(
                        valueListenable:
                            _studentsLessonDetailView.studentsAttendanceList,
                        builder: (_, value, ___) {
                          return AttendanceHistoryWidget(
                            convertDate:
                                _studentsLessonDetailView.extractTimestamp,
                            convertDateTwo:
                                _studentsLessonDetailView.convertTime,
                            sampleStudentAttendanceList:
                                _studentsLessonDetailView
                                    .studentsAttendanceList.value,
                          );
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
