import 'package:qr_attendance_project/export.dart';

class AttendanceHistoryWidget extends StatelessWidget {
  const AttendanceHistoryWidget({
    super.key,
    required this.sampleStudentAttendanceList,
    required this.convertDate,
    required this.convertDateTwo,
  });
  final List<AttendanceModel?> sampleStudentAttendanceList;
  final String Function(String) convertDate;
  final String Function(String) convertDateTwo;


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Card(
        shadowColor: Theme.of(context).cardColor,
        child: sampleStudentAttendanceList.isNotEmpty
            ? Column(
                children: [
                  EmptyWidget(),
                  Expanded(
                    child: Text(
                      LocaleKeys.studentLessonDetail_pastAttendance.locale,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Expanded(
                      flex: 7,
                      child: ListView.separated(
                        padding: WidgetSizes.smallPadding.value,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomIconCreator(
                                    iconPath: 'assets/icons/start-date.png',
                                  ),
                                  Text(
                                    LocaleKeys
                                        .studentLessonDetail_startDate.locale,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Text(
                                    convertDate(
                                        sampleStudentAttendanceList[index]
                                                ?.qrCodeData ??
                                            ''),
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ],
                              ),
                              EmptyWidget(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomIconCreator(
                                    iconPath: 'assets/icons/play-button.png',
                                  ),
                                  Text(
                                    LocaleKeys
                                        .studentLessonDetail_endDate.locale,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Text(
                                    convertDateTwo(
                                        sampleStudentAttendanceList[index]
                                                ?.createdDate
                                                ?.toDate()
                                                .toString() ??
                                            ''),
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ],
                              )
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            color: Theme.of(context)
                                .hintColor
                                .withValues(alpha: 1),
                          );
                        },
                        itemCount: sampleStudentAttendanceList.length,
                      ))
                ],
              )
            : CustomEmptyDataWidget(
                emptySize: 0,
                iconSize: screenHeight * 0.4,
                title: LocaleKeys.studentLessonDetail_noHaveAttendance.locale,
                imagePath: 'assets/icons/student_no_attendance.png',
              ));
  }
}
