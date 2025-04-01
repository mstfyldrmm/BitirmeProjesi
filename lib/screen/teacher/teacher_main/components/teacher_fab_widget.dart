import 'package:flutter/material.dart';
import 'package:qr_attendance_project/custom/icon_creater.dart';
import 'package:qr_attendance_project/custom/navigate_to_widget.dart';
import 'package:qr_attendance_project/screen/teacher/teacher_add_lesson/teacher_add_lesson_screen.dart';

class TeacherFabWidget extends StatelessWidget with IconCreater, NavigatorManager{
  TeacherFabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: iconCreaterColor('assets/icons/add-database.png', context),
        onPressed: () {
          navigateToWidget(context, TeacherAddLessonScreen());
        });
  }
}
