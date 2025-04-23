import 'package:qr_attendance_project/export.dart';



Widget JoinAttendanceButtonWidget(BuildContext context) {
  return Center(
    child: Column(
      children: [
        Expanded(
            flex: 5,
            child: IconButton(
                style: ButtonStyle(elevation: WidgetStatePropertyAll(10)),
                onPressed: () {},
                icon: Shimmer.fromColors(
                  baseColor:
                      Theme.of(context).hintColor.withAlpha(200), // daha koyu
                  highlightColor:
                      Theme.of(context).hintColor.withAlpha(60), // daha açık
                  child: CustomIconCreator(
                    iconColor: Theme.of(context)
                        .hintColor
                        .withAlpha(255), // orijinal renk
                    iconPath: 'assets/images/qr-scan-student.png',
                  ),
                ))),
        Expanded(
          child: Column(
            children: [
              Shimmer.fromColors(
                baseColor:
                    Theme.of(context).hintColor.withAlpha(200), // daha koyu
                highlightColor: Theme.of(context).hintColor.withAlpha(60),
                child: Text(
                  LocaleKeys.studentLessonDetail_joinAttendance.locale,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              EmptyWidget(
                height: 40,
              )
            ],
          ),
        ),
      ],
    ),
  );
}
