import 'package:flutter/material.dart';
import 'package:qr_attendance_project/screen/teacher/teacher_add_lesson/teacher_add_lesson_view.dart';
import 'package:qr_attendance_project/screen/widgets/custom_icon_creator.dart';

class ExelFile extends StatelessWidget {
  const ExelFile({super.key, required this.vm});
  final TeacherAddLessonView vm;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: CustomIconCreator(iconPath: 'assets/icons/excel-2.png'),
            ),
            SizedBox(
              width: 30,
            ),
            Text(
              vm.exelFile.value?.path.substring(79) ?? '',
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
        IconButton(
            onPressed: () {
              vm.exelFile.value = null;
              vm.fileSelectedStateManage();
            },
            icon: Icon(
              Icons.delete_outline_rounded,
              size: 40,
              color: Theme.of(context).colorScheme.error,
            ))
      ],
    );
  }
}
