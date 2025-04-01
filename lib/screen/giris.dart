import 'package:flutter/material.dart';
import 'package:qr_attendance_project/custom/login_button.dart';
import 'package:qr_attendance_project/custom/navigate_to_widget.dart';
import 'package:qr_attendance_project/screen/student/student_sign_in.dart/student_sign_in_screen.dart';
import 'package:qr_attendance_project/screen/ogretmen/ogretmen_giris.dart';

class Giris extends StatelessWidget with NavigatorManager {
  const Giris({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/images.jpeg',
              ),
              fit: BoxFit.cover)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Spacer(),
                  ClipOval(child: Image.asset('assets/images/logo-3.png')),
                  Spacer(),
                  Spacer(),
                  LoginButton(
                    title: 'Öğrenci Girişi',
                    func: () {
                      navigateToNormalWidget(context, OgrenciGiris());
                    },
                  ),
                  LoginButton(
                    title: 'Öğretmen Girişi',
                    func: () {
                      navigateToNormalWidget(context, OgretmenGiris());
                    },
                  )
                ],
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
