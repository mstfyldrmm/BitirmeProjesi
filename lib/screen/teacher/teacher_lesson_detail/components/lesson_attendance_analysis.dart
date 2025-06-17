import 'package:flutter/material.dart';
import 'package:qr_attendance_project/custom/circularPercentWidget.dart';

Widget LessonAttendanceAnalysis({
  required Map<String, int> attendanceAnalysis,
  required String lessonId,
  required String lessonName,
}) {
  final dates = attendanceAnalysis.keys.toList();

  return PageView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: dates.length,
    itemBuilder: (BuildContext context, int index) {
      final date = dates[index];
      final percentage = attendanceAnalysis[date] ?? 0;
      final percentDouble = percentage / 100.0;

      return Card(
        margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                percentDouble,
                "%$percentage\nKatılım",
              ),
              SizedBox.shrink()
            ],
          ),
        ),
      );
    },
  );
}
