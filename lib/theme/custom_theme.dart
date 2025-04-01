import 'package:flutter/material.dart';

final ThemeData myTheme = ThemeData(
  colorScheme: ColorScheme(
    primary: Color(0xFF003366), // Lacivert (Ana Renk)
    secondary: Color(0xFFC8102E), // Kırmızı (İkincil Renk)
    tertiary: Color(0xFFFFFFFF), // Açık Lacivert (Arka Plan)
    surface: Color(0xFFFFFFFF), // Beyaz (Kartlar ve UI bileşenleri için)
    error: Color(0xFFA30000), // Koyu Kırmızı (Hata Rengi)
    onPrimary: Colors.white, // Lacivert üstündeki yazılar beyaz
    onSecondary: Colors.white, // Kırmızı üstündeki yazılar beyaz
    onError: Colors.white, // Arka plan üzerindeki metin rengi
    onSurface: Color(0xFF333333), // UI bileşenleri üzerindeki metin rengi
    brightness: Brightness.dark, // Koyu Tema için
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF003366), // Lacivert AppBar
    foregroundColor: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFFC8102E), // Kırmızı Butonlar
      foregroundColor: Colors.white,
    ),
  ),
);
