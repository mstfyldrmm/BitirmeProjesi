import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

Widget circularPercentWidget(
    BuildContext context, double percent, String text) {
  return CircularPercentIndicator(
    radius: 80.0,
    lineWidth: 10.0,
    animation: true,
    animationDuration: 1000,
    percent: percent, // %75
    center: Text(
      textAlign: TextAlign.center,
      text,
      style: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(fontWeight: FontWeight.bold),
    ),
    circularStrokeCap: CircularStrokeCap.round,
  );
}
