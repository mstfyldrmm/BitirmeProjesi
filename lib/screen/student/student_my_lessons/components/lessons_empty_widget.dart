import 'package:flutter/material.dart';
import 'package:qr_attendance_project/custom/ext/ext_string_localizations.dart';
import 'package:qr_attendance_project/generated/locale_keys.g.dart';

class LessonsEmptyWidget extends StatelessWidget {
  const LessonsEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Image.asset('assets/icons/sleep.png'),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            LocaleKeys.studentMain_studentEmptyLessonMessage.locale,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        )
      ],
    );
  }
}
