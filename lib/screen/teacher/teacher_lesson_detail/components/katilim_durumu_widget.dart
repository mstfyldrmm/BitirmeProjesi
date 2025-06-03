import 'package:flutter/material.dart';
import 'package:qr_attendance_project/custom/circularPercentWidget.dart';
import 'package:qr_attendance_project/screen/teacher/teacher_attendance_analysis/teacher_attendance_analysis_screen.dart';

Widget katilimDurumu(String date,
    {required String lessonId, required String lessonName}) {
  return PageView.builder(itemBuilder: (BuildContext context, int index) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            date,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          circularPercentWidget(
            context,
            0.6,
            "%50\nKatılım",
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TeacherAttendanceAnalysisScreen(
                          lessonId: lessonId,
                          lessonName: lessonName,
                        )));
              },
              icon: Image.asset(
                'assets/icons/file.png',
                color: Theme.of(context).hintColor,
              ))
        ],
      ),
    );
  });
}
