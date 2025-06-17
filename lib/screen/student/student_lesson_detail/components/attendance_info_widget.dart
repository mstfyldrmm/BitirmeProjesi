import 'package:qr_attendance_project/export.dart';

class AttendanceInfoWidget extends StatelessWidget with IconCreater {
  final VoidCallback onTapQrScanner;
  final double attendancePercentage;
  final int totalAttendanceCount;
  const AttendanceInfoWidget({
    super.key,
    required this.onTapQrScanner,
    required this.attendancePercentage,
    required this.totalAttendanceCount,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 4.8;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 4,
          color: Theme.of(context).colorScheme.outline,
        ),
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Column(
          children: totalAttendanceCount > 0
              ? [
                  Expanded(
                    child: joinAttendanceButton(context, height),
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.outline,
                    thickness: 2,
                  ),
                  Expanded(
                    child: attendanceStatus(context),
                  ),
                ]
              : [
                  joinAttendanceButton(context, height),
                  EmptyWidget(),
                  Divider(
                    color: Theme.of(context).colorScheme.outline,
                    thickness: 2,
                  ),
                  EmptyWidget(),
                  Row(
                    children: [
                      CustomIconCreator(
                        iconPath: 'assets/icons/no_start_attendance.png',
                        iconSize: height * 0.9,
                        iconColor: Theme.of(context).hintColor.withValues(
                              alpha: 1,
                            ),
                      ),
                      Expanded(
                        child: Text(
                          LocaleKeys.studentLessonDetail_noAttendanceYet.locale,
                          style: Theme.of(context).textTheme.titleMedium,
                          softWrap: true,
                          maxLines: null,
                        ),
                      )
                    ],
                  )
                ]),
    );
  }

  Widget attendanceStatus(
    BuildContext context,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              attendancePercentage >= 0.6
                  ? LocaleKeys.studentLessonDetail_lessonStateActive.locale
                  : LocaleKeys.studentLessonDetail_lessonStateInActive.locale,
              style: Theme.of(context).textTheme.titleMedium,
              overflow: TextOverflow.ellipsis,
            ),
            CustomIconCreator(
              iconPath: attendancePercentage >= 0.6
                  ? 'assets/icons/accept.png'
                  : 'assets/icons/cancel.png',
            ),
          ],
        ),
        CircularPercentIndicator(
          radius: 75,
          lineWidth: 8.0,
          animation: true,
          animationDuration: 1000,
          progressColor:
              attendancePercentage >= 0.6 ? Colors.green : Colors.red,
          percent: attendancePercentage,
          center: Text(
            textAlign: TextAlign.center,
            "%${(attendancePercentage * 100).toInt()}\n${LocaleKeys.teacherLessonDetail_attendance.locale}",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          circularStrokeCap: CircularStrokeCap.round,
        ),
      ],
    );
  }

  Widget joinAttendanceButton(BuildContext context, double iconSize) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            IconButton(
              style: ButtonStyle(elevation: WidgetStatePropertyAll(10)),
              onPressed: () => onTapQrScanner.call(),
              icon: Shimmer.fromColors(
                baseColor: Theme.of(context).hintColor.withAlpha(200),
                highlightColor: Theme.of(context).hintColor.withAlpha(60),
                child: CustomIconCreator(
                  iconColor: Theme.of(context).hintColor.withAlpha(255),
                  iconPath: 'assets/images/qr-scan-student.png',
                  iconSize: iconSize,
                ),
              ),
            ),
            CustomIconCreator(
              iconPath: 'assets/icons/right-arrow.png',
              iconSize: 40,
              iconColor: Theme.of(context).hintColor.withValues(
                    alpha: 1,
                  ),
            ),
          ],
        ),
        Shimmer.fromColors(
          baseColor: Theme.of(context).hintColor.withAlpha(200),
          highlightColor: Theme.of(context).hintColor.withAlpha(60),
          child: Text(
            LocaleKeys.studentLessonDetail_joinAttendance.locale,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ],
    );
  }
}
