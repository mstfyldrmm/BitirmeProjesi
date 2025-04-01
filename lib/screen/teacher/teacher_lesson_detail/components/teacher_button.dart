import 'package:flutter/material.dart';
import 'package:qr_attendance_project/custom/icon_creater.dart';
import 'package:qr_attendance_project/custom/navigate_to_widget.dart';
import 'package:qr_attendance_project/screen/teacher/teacher_attendance/teacher_attendance_screen.dart';


class TeacherButton extends StatelessWidget with NavigatorManager, IconCreater {
   TeacherButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    shape: CircleBorder(),
                  ),
                  child: iconCreaterNoColor(
                      'assets/icons/calendar-with-check.png', context),
                ),
                Text('Yoklama Başlat',
                    style: Theme.of(context).textTheme.titleMedium)
              ],
            ),
            VerticalDivider(
              thickness: 2, // Çizginin kalınlığı
              width: 10, // Butonlar arası boşluk
              // Çizginin rengi
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    navigateToNormalWidget(context, TeacherAttendanceScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    shape: CircleBorder(),
                  ),
                  child:
                      iconCreaterNoColor('assets/icons/calendar.png', context),
                ),
                Text(
                  'Geçmiş Yoklamalar',
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
