import 'package:flutter/material.dart';
import 'package:qr_attendance_project/custom/icon_creater.dart';
import 'package:qr_attendance_project/screen/teacher/teacher_add_lesson/teacher_add_lesson_screen.dart';
import 'package:qr_attendance_project/screen/teacher/teacher_add_lesson/teacher_add_lesson_view.dart';

class ExelButton extends StatelessWidget with IconCreater {
   ExelButton({super.key, required this.vm});
  final TeacherAddLessonView vm; 
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              vm.pickExcelFile();
            },
            icon: iconCreaterColor('assets/icons/upload-file.png', context)),
        Text(
          'Öğrenci Listesinin\n Exel Dosyasını Yükle',
          style: Theme.of(context).textTheme.titleMedium,
        )
      ],
    );
  }
}
