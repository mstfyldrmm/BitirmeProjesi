import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget StudentAttendanceStartButton(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      // Butona tıklama işlemi
    },
    style: ElevatedButton.styleFrom(
      shape: CircleBorder(),
    ),
    child: LottieBuilder.asset(
      'assets/lottie/qr.json',
      fit: BoxFit.cover,
    ), // Butonun içeriği (ikon)
  );
}
