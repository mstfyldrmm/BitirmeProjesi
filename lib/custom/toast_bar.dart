import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message, {required isError}) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: isError ? Colors.red : Colors.green,
    toastLength: Toast.LENGTH_SHORT, // Kısa veya uzun gösterme
    gravity: ToastGravity.BOTTOM, // Toast'ın alt kısımda gözükmesi
    timeInSecForIosWeb:
        2, // iOS ve web için gösterim süresi (saniye) // Arka plan rengi
    textColor: Colors.white, // Metin rengi
    fontSize: 16.0, // Yazı boyutu
  );
}
