import 'package:qr_attendance_project/export.dart';
import 'package:qr_attendance_project/screen/teacher/teacher_attendance/companents/attendance_list_view_widget.dart';

class TeacherAttendanceScreen extends StatefulWidget {
  TeacherAttendanceScreen({super.key, this.lessonId, required this.lessonName});
  String? lessonId;
  final String lessonName;

  @override
  State<TeacherAttendanceScreen> createState() =>
      _TeacherAttendanceScreenState();
}

class _TeacherAttendanceScreenState extends State<TeacherAttendanceScreen> {
  late final TeacherAttendanceView _vm;
  TextEditingController dateController = TextEditingController();
  TextEditingController studentController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _vm = TeacherAttendanceView();
    _vm.getRegisteredStudents(widget.lessonId!);
    dateController.text = DateTime.now().toString().split(" ")[0];
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        context,
        title: LocaleKeys.teacherTitle_attendanceDetail.locale,
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.transparent,
        onPressed: () {
          _vm.sharePDF(
            widget.lessonName,
            _vm.selectedDate.value,
            _vm.attendancesData.value,
          );
        },
        child: CustomIconCreator(
          iconPath: 'assets/icons/pdf.png',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: WidgetSizes.normalPadding.value,
            child: Column(
              children: [
                ValueListenableBuilder(
                    valueListenable: _vm.selectedDate,
                    builder: (_, value, __) {
                      return CustomTextField(
                        readOnly: true,
                        controller: dateController,
                        icon: IconButton(
                          onPressed: () async {
                            dateController.text = await _vm.selectDate(context);
                            _vm.getRegisteredStudents(widget.lessonId!);
                            _vm.createPdfFile(_vm.attendancesData.value,
                                _vm.selectedDate.value, widget.lessonName);
                          },
                          icon: Icon(
                            Icons.calendar_today_outlined,
                          ),
                        ),
                        title: LocaleKeys.teacherLessonDetail_selectDate.locale,
                      );
                    }),
                EmptyWidget(
                  height: 20,
                ),
                ValueListenableBuilder(
                    valueListenable: _vm.filteredAttendancesData,
                    builder: (_, __, ___) {
                      return _vm.attendancesData.value.isEmpty
                          ? CustomEmptyDataWidget(
                              title:
                                  "${_vm.selectedDate.value} ${LocaleKeys.teacherLessonDetail_noAttendance.locale}",
                              imagePath: 'assets/icons/emptyClass.png',
                            )
                          : Column(
                              children: [
                                CustomTextField(
                                  title: LocaleKeys
                                      .teacherLessonDetail_searchStudent.locale,
                                  icon: Icon(Icons.search_outlined),
                                  controller: studentController,
                                  onChanged: (String text) {
                                    _vm.filterAttendances(text);
                                  },
                                ),
                                EmptyWidget(
                                  height: 20,
                                ),
                                titleWidgets(),
                                EmptyWidget(
                                  height: 20,
                                ),
                                AttendanceListViewWidget(
                                  height: height * 0.48,
                                  attendancesData:
                                      _vm.filteredAttendancesData.value,
                                ),
                              ],
                            );
                    }),
              ],
            )),
      ),
    );
  }

  Widget titleWidgets() {
    return CustomCardWidget(
        paddingValue: 20,
        childWidget:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            'Number',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            'Name',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            'Surname',
            style: Theme.of(context).textTheme.titleMedium,
          )
        ]));
  }
}
