import 'package:qr_attendance_project/export.dart';

class StudentLessonCard extends StatelessWidget {
  final BuildContext context;
  final LessonModel? lessonModel;
  final String iconAddress;
  final VoidCallback onTapLessonCard;
  const StudentLessonCard({
    super.key,
    required this.context,
    required this.lessonModel,
    required this.iconAddress,
    required this.onTapLessonCard,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: EdgeInsets.only(top: 20, left: 20, right: 20),
        leading: CustomIconCreator(
          iconPath: iconAddress,
          iconColor: Theme.of(context).hintColor.withValues(alpha: 1),
        ),
        onTap: () => onTapLessonCard.call(),
        title: Text(
          lessonModel?.lessonName ?? '',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lessonModel?.teacherName ?? '',
              ),
              Text(lessonModel?.section ?? ''),
            ],
          ),
        ),
        trailing: Text(
          lessonModel?.lessonCode.toString() ?? '',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
