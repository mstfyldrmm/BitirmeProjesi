import 'package:flutter/material.dart';
import 'package:qr_attendance_project/custom/icon_creater.dart';
import 'package:qr_attendance_project/custom/widget_sizes.dart';

class LessonCaseText extends StatelessWidget with IconCreater{
  const LessonCaseText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: WidgetSizes.smallPadding.value,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Ders Devam Durumu: Aktif',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          iconCreaterNoColor('assets/icons/accept.png', context)
        ],
      ),
    );
  }
}
