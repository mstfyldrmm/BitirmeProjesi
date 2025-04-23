import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:qr_attendance_project/export.dart';

class TeacherLessonItem extends StatelessWidget
    with NavigatorManager, IconCreater {
  TeacherLessonItem({
    super.key,
    required this.lesson,
    required this.onPressDismissed,
    required this.onPressAction,
  });
  final List<LessonModel?> lesson;
  final void Function(String) onPressDismissed;
  final void Function(String) onPressAction;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: lesson.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 3),
            elevation: 10,
            shadowColor: Theme.of(context).scaffoldBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Slidable(
              key: ValueKey(lesson[index]!.lessonId!),
              endActionPane: ActionPane(
                motion: ScrollMotion(),
                dismissible: DismissiblePane(
                  onDismissed: () => onPressDismissed(lesson[index]!.lessonId!),
                ),
                children: [
                  SlidableAction(
                    onPressed: (context) =>
                        onPressAction(lesson[index]!.lessonId!),
                    backgroundColor: const Color.fromARGB(255, 255, 28, 12),
                    foregroundColor: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    icon: Icons.delete,
                    spacing: 10,
                    label: 'Delete',
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: WidgetSizes.normalPadding.value,
                title: Text("${lesson[index]?.lessonName?.toUpperCase()}",
                    style: Theme.of(context).textTheme.titleMedium),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    toTitleCase(lesson[index]?.section ?? ''),
                  ),
                ),
                leading: Text(
                  "${lesson[index]?.lessonCode}",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                trailing: iconCreaterColor('assets/icons/teacher.png', context),
                onTap: () {
                  navigateToNormalWidget(
                    context,
                    TeacherLessonDetailScreen(
                      lessonModel: lesson[index]!,
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  String toTitleCase(String text) {
    return text
        .split(" ")
        .map((word) => toBeginningOfSentenceCase(word))
        .join(" ");
  }
}
