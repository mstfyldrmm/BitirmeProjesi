import 'package:flutter/material.dart';
import 'package:qr_attendance_project/custom/icon_creater.dart';
import 'package:qr_attendance_project/custom/navigate_to_widget.dart';
import 'package:qr_attendance_project/custom/widget_sizes.dart';
import 'package:qr_attendance_project/model/lesson_model.dart';
import 'package:qr_attendance_project/screen/teacher/teacher_lesson_detail/teacher_lesson_detail_screen.dart';

class TeacherLessonCreater extends StatelessWidget
    with NavigatorManager, IconCreater {
  TeacherLessonCreater({super.key, required this.dersler});
  final List<LessonModel?> dersler;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      itemCount: dersler.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 3),
          elevation: 10,
          shadowColor: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            contentPadding: WidgetSizes.normalPadding.value,
            title: Text(dersler[index]?.lessonName ?? '',
                style: Theme.of(context).textTheme.titleMedium),
            subtitle: Text(
              dersler[index]?.lessonId ?? '',
            ),
            trailing: iconCreaterColor('assets/icons/teacher.png', context),
            onTap: () {
              navigateToNormalWidget(context, TeacherLessonDetailScreen());
            },
          ),
        );
      },
    ));
  }
}
