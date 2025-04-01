import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

Widget LessonAttendanceBar(double dersDevam, BuildContext context) {
  return CircularPercentIndicator(
    radius: 80.0,
    lineWidth: 10.0,
    animation: true,
    animationDuration: 1000,
    percent: dersDevam, // %75
    center: Text(
      textAlign: TextAlign.center,
      "%${(dersDevam * 100).toInt()}\nKatılım",
      style: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(fontWeight: FontWeight.bold),
    ),

    circularStrokeCap: CircularStrokeCap.round,
  );
}
