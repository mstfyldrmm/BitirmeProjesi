import 'package:qr_attendance_project/export.dart';


class LessonsEmptyWidget extends StatelessWidget {
  const LessonsEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: CustomIconCreator(
              iconPath: 'assets/icons/sleep.png',
              iconColor: Theme.of(context).hintColor.withValues(alpha: 1)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            LocaleKeys.studentMain_studentEmptyLessonMessage.locale,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        )
      ],
    );
  }
}
