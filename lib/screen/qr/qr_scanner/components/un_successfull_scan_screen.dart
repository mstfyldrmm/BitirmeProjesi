import 'package:flutter/material.dart';
import 'package:qr_attendance_project/export.dart';

class UnSuccessfullScanScreen extends StatelessWidget with NavigatorManager {
  UnSuccessfullScanScreen(
      {super.key,
      required this.lessonName,
      required this.lessonModel,
      required this.studentModel, required this.errorMessage});
  final String lessonName;
  final LessonModel lessonModel;
  final StudentModel studentModel;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: WidgetSizes.normalPadding.value,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomIconCreator(
              iconPath: 'assets/icons/unsuccessfull_attendance.png',
              iconColor: Theme.of(context).hintColor.withValues(
                    alpha: 1,
                  ),
            ),
            Text('Hata', style: Theme.of(context).textTheme.headlineLarge),
            Text(
                '${lessonName} ${errorMessage}',
                style: Theme.of(context).textTheme.titleMedium),
            Row(
              children: [
                IconButton(
                  onPressed: () => {
                    Navigator.pop(context),
                    Navigator.pop(context),
                    Navigator.pop(context),
                  },
                  icon: CustomIconCreator(
                    iconSize: 100,
                    iconPath: 'assets/icons/arrow-left-two.png',
                    iconColor: Theme.of(context).hintColor.withValues(alpha: 1),
                  ),
                ),
                Text(
                  LocaleKeys.studentLessonDetail_backToLessons.locale,
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
