import 'package:qr_attendance_project/export.dart';

class AttendanceInfoWidget extends StatelessWidget with IconCreater {
  final VoidCallback onTapQrScanner;
  const AttendanceInfoWidget({
    super.key,
    required this.onTapQrScanner,
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
        children: [
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
        ],
      ),
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
              LocaleKeys.studentLessonDetail_lessonStateActive.locale,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            CustomIconCreator(iconPath: 'assets/icons/accept.png')
          ],
        ),
        CircularPercentIndicator(
          radius: 70,
          lineWidth: 8.0,
          animation: true,
          animationDuration: 1000,
          progressColor: Colors.green,
          percent: 0.75,
          center: Text(
            textAlign: TextAlign.center,
            "%${(0.75 * 100).toInt()}\nKatılım",
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
      children: [
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
        Column(
          children: [
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
        ),
      ],
    );
  }
}
