import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:qr_attendance_project/custom/icon_creater.dart';
import 'package:qr_attendance_project/custom/navigate_to_widget.dart';
import 'package:qr_attendance_project/custom/widget_sizes.dart';
import 'package:qr_attendance_project/export.dart';
import 'package:qr_attendance_project/model/lesson_model.dart';
import 'package:qr_attendance_project/screen/teacher/teacher_lesson_detail/teacher_lesson_detail_screen.dart';

class TeacherLessonCreater extends StatelessWidget
    with NavigatorManager, IconCreater {
  TeacherLessonCreater({super.key, required this.dersler, required this.vm});
  final List<LessonModel?> dersler;
  final TeacherMyLessonsView vm;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      itemCount: dersler.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 3),
          elevation: 10,
          shadowColor: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Slidable(
            key: ValueKey(dersler[index]!.lessonId!),
            endActionPane: ActionPane(
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (_) {
                    vm.deleteTeacherLesson(dersler[index]!.lessonId!);
                  },
                  backgroundColor: const Color.fromARGB(255, 255, 28, 12),
                  foregroundColor: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  icon: Icons.delete,
                  spacing: 10,
                  label: 'Delete',
                ),
              ],
              dismissible: DismissiblePane(
                onDismissed: () {
                  vm.deleteTeacherLesson(dersler[index]!.lessonId!);
                },
              ),
            ),
            child: ListTile(
              contentPadding: WidgetSizes.normalPadding.value,
              title: Text("${dersler[index]?.lessonName?.toUpperCase()}",
                  style: Theme.of(context).textTheme.titleMedium),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  toTitleCase(dersler[index]?.section ?? ''),
                ),
              ),
              leading: Text(
                "${dersler[index]?.lessonCode}",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              trailing: iconCreaterColor('assets/icons/teacher.png', context),
              onTap: () {
                navigateToNormalWidget(
                    context,
                    TeacherLessonDetailScreen(
                      lessonModel: dersler[index]!,
                    ));
              },
            ),
          ),
        );
      },
    ));
  }

  String toTitleCase(String text) {
    return text
        .split(" ")
        .map((word) => toBeginningOfSentenceCase(word) ?? "")
        .join(" ");
  }
}
