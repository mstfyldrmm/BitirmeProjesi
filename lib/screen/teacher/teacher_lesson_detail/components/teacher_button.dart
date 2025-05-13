import 'package:flutter/material.dart';
import 'package:qr_attendance_project/custom/icon_creater.dart';
import 'package:qr_attendance_project/custom/navigate_to_widget.dart';
import 'package:qr_attendance_project/export.dart';
import 'package:qr_attendance_project/screen/teacher/teacher_attendance/teacher_attendance_screen.dart';
import 'package:qr_attendance_project/screen/widgets/custom_card_widget.dart';

class TeacherButton extends StatelessWidget with NavigatorManager, IconCreater {
  TeacherButton(
      {super.key,
      required this.startAttendance,
      required this.lessonId,
      required this.lessonName});
  final VoidCallback startAttendance;
  final String lessonId;
  final String lessonName;
  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      paddingValue: 20,
      childWidget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => startAttendance.call(),
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    shape: CircleBorder(),
                  ),
                  child: iconCreaterNoColor(
                      'assets/icons/calendar-with-check.png', context),
                ),
                Text(
                  LocaleKeys.teacherLessonDetail_createAttendance.locale,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          VerticalDivider(
            thickness: 2, // Çizginin kalınlığı
            width: 10, // Butonlar arası boşluk
            // Çizginin rengi
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    navigateToNormalWidget(
                        context,
                        TeacherAttendanceScreen(
                          lessonName: lessonName,
                          lessonId: lessonId,
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    shape: CircleBorder(),
                  ),
                  child:
                      iconCreaterNoColor('assets/icons/calendar.png', context),
                ),
                Text(
                  LocaleKeys.teacherLessonDetail_pastAttendance.locale,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
