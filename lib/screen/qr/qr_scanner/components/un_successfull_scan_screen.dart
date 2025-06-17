import 'package:qr_attendance_project/export.dart';

class UnSuccessfullScanScreen extends StatelessWidget with NavigatorManager {
  UnSuccessfullScanScreen(
      {super.key,
      required this.lessonName,
      required this.lessonModel,
      required this.studentModel,
      required this.errorMessage});
  final String lessonName;
  final LessonModel lessonModel;
  final StudentModel studentModel;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    
    return PopScope(
      canPop: false,
      child: Scaffold(
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
              Text(
                LocaleKeys.teacherLessonDetail_bug.locale,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                '${lessonName} ${errorMessage}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => {
                      navigateToNormalWidget(context,
                          StudentDrawerContent(userId: studentModel.studentId))
                    },
                    icon: CustomIconCreator(
                      iconSize: 64,
                      iconPath: 'assets/icons/arrow-left-two.png',
                      iconColor:
                          Theme.of(context).hintColor.withValues(alpha: 1),
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
      ),
    );
  }
}
