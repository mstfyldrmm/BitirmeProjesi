import 'package:flutter/material.dart';
import 'package:qr_attendance_project/custom/app_bar.dart';
import 'package:qr_attendance_project/custom/widget_sizes.dart';
import 'package:qr_attendance_project/model/yoklama.dart';
import 'package:qr_attendance_project/screen/teacher/teacher_attendance/components/attendance_widget.dart';

class TeacherAttendanceScreen extends StatelessWidget {
  const TeacherAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.transparent,
        onPressed: () {},
        child: Image.asset(YoklamaDetayString().iconPath),
      ),
      appBar: CustomAppBar(context, title: YoklamaDetayString().title),
      body: Padding(
        padding: WidgetSizes.normalPadding.value,
        child: PageView.builder(
          itemCount: yoklamaListesi.length,
          itemBuilder: (BuildContext context, int index) {
            return AttendanceWidget(
              yoklama: yoklamaListesi[index],
            );
          },
        ),
      ),
    );
  }
}

class YoklamaDetayString {
  String iconPath = 'assets/icons/pdf.png';
  String title = 'Yoklama Detay Ekranı';
}
