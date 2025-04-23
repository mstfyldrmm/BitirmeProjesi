import 'package:qr_attendance_project/export.dart';

class AttendanceInfoWidget extends StatelessWidget with IconCreater {
  const AttendanceInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
          Expanded(flex: 5, child: AttendanceNotAvailable(context)),
          Expanded(
              child: Divider(
            color: Theme.of(context).colorScheme.outline,
            thickness: 2,
          )),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.studentLessonDetail_lessonStateActive.locale,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                CustomIconCreator(iconPath: 'assets/icons/accept.png')
              ],
            ),
          ),
          Expanded(flex: 5, child: LessonAttendanceBar(0.75, context)),
        ],
      ),
    );
  }

  Widget LessonAttendanceBar(double dersDevam, BuildContext context) {
    return CircularPercentIndicator(
      radius: 70,
      lineWidth: 8.0,
      animation: true,
      animationDuration: 1000,
      progressColor: Colors.green,
      percent: dersDevam, // %75
      center: Text(
        textAlign: TextAlign.center,
        "%${(dersDevam * 100).toInt()}\nKatılım",
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.bold),
      ),

      circularStrokeCap: CircularStrokeCap.round,
    );
  }

  Widget AttendanceNotAvailable(BuildContext context) {
    return Column(children: [
      EmptyWidget(),
      CustomIconCreator(
        iconPath: 'assets/icons/clockk.png',
        iconColor: Theme.of(context).hintColor.withValues(alpha: 1),
      ),
      EmptyWidget(
        height: 10,
      ),
      Text(LocaleKeys.studentLessonDetail_noAttendance.locale)
    ]);
  }
}
