import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:qr_attendance_project/screen/ogretmen/ogretmen_giris.dart';

void showCustomLoadingDialog(BuildContext context, Widget navigateWidget) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pop();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => navigateWidget),
        );
      });

      return Dialog(
        shadowColor: Colors.transparent,
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            color: Colors.transparent,
            child: Center(
              child: LoadingAnimationWidget.twoRotatingArc(
                color: Theme.of(context).hintColor,
                size: 60,
              ),
            ),
          ),
        ),
      );
    },
  );
}
