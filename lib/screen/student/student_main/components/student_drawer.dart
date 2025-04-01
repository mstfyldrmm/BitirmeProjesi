import 'package:flutter/material.dart';
import 'package:qr_attendance_project/custom/icon_creater.dart';
import 'package:qr_attendance_project/custom/navigate_to_widget.dart';
import 'package:qr_attendance_project/screen/student/student_account/student_account_screen.dart';
import 'package:qr_attendance_project/screen/student/student_main/ogrenci_ana_ekran.dart';
import 'package:qr_attendance_project/screen/student/ogrenci_hesabim.dart';
import 'package:qr_attendance_project/screen/student/student_main/student_main_screen.dart';

class StudentDrawer extends StatelessWidget with IconCreater, NavigatorManager {
  const StudentDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 3,
              child: iconCreaterColor('assets/icons/drawer.png', context)),
          Expanded(
            child: childCreater('Ana Ekran', Icon(Icons.home_filled), context,
                StudentMainScreen()),
          ),
          Expanded(
              child: childCreater(
                  'Taleplerim',
                  Icon(Icons.help_outline_outlined),
                  context,
                  StudentMainScreen())),
          Expanded(
              child: childCreater('Hesabım', Icon(Icons.person_2_outlined),
                  context, StudentAccountScreen())),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }

  Container childCreater(String icerik, Widget icons, BuildContext context,
      Widget navigateWidget) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1), // Kenarlık ekler
        // Köşeleri yuvarlatır
      ),
      child: ListTile(
        onTap: () {
          navigateToNoBackWidget(context, navigateWidget);
        },
        enabled: true,
        contentPadding: EdgeInsets.all(20),
        title: Text(
          icerik,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        leading: icons,
      ),
    );
  }
}
