import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_attendance_project/custom/app_bar.dart';

import 'package:qr_attendance_project/custom/icon_creater.dart';
import 'package:qr_attendance_project/custom/navigate_to_widget.dart';
import 'package:qr_attendance_project/custom/widget_sizes.dart';
import 'package:qr_attendance_project/export.dart';
import 'package:qr_attendance_project/provider/theme_provider.dart';
import 'package:qr_attendance_project/screen/teacher/teacher_lesson_detail/components/lesson_info.dart';
import 'package:qr_attendance_project/screen/teacher/teacher_lesson_detail/components/teacher_button.dart';

import 'components/katilim_durumu_widget.dart';

class TeacherLessonDetailScreen extends StatefulWidget {
  const TeacherLessonDetailScreen({super.key, required this.lessonModel});
  final LessonModel lessonModel;

  @override
  State<TeacherLessonDetailScreen> createState() => _OgretmenDersDetayState();
}

class _OgretmenDersDetayState extends State<TeacherLessonDetailScreen>
    with NavigatorManager, IconCreater {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    bool isStarted = false;

    void _toggleButton() {
      setState(() {
        isStarted = !isStarted;
      });

      if (isStarted) {
        // Start butonuna basıldığında çalışacak işlemler
        debugPrint("Başlatıldı!");
      } else {
        // Stop butonuna basıldığında çalışacak işlemler
        debugPrint("Durduruldu!");
      }
    }

    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(context, title: 'Ders Adi'),
      body: Padding(
        padding: WidgetSizes.normalPadding.value,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                flex: 2,
                child: LessonInfo(
                  lessonModel: widget.lessonModel,
                )),
            Expanded(child: TeacherButton(), flex: 2),
            Expanded(child: katilimDurumu('as'), flex: 2)
          ],
        ),
      ),
    );
  }
}
