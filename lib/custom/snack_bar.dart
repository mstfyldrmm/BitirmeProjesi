import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String text, bool isError) {
  final snackBarOkey = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isError
            ? Image.asset(
                'assets/icons/cancel.png',
              )
            : Image.asset('assets/icons/accept.png'), // Hata ikonu
        SizedBox(width: 8), // Boşluk
        Expanded(
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
    backgroundColor: isError ? Colors.red : Colors.green,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10), // Yuvarlak köşeler
    ),
    behavior: SnackBarBehavior.floating, // Yukarıda durmasını sağlar
    duration: Duration(seconds: 3), // 3 saniye sonra otomatik kapanır
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBarOkey);
}
