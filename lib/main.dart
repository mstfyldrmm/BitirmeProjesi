import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_attendance_project/firebase_options.dart';
import 'package:qr_attendance_project/model/yoklama.dart';
import 'package:qr_attendance_project/provider/theme_provider.dart';
import 'package:qr_attendance_project/screen/deneme.dart';
import 'package:qr_attendance_project/screen/student/student_main/ogrenci_ana_ekran.dart';
import 'package:qr_attendance_project/screen/student/student_lesson_detail/student_lesson_detail_screen.dart';
import 'package:qr_attendance_project/screen/student/ogrenci_ders_kayit_talep.dart';
import 'package:qr_attendance_project/screen/student/student_sign_in.dart/student_sign_in_screen.dart';
import 'package:qr_attendance_project/screen/student/ogrenci_hesabim.dart';
import 'package:qr_attendance_project/screen/student/ogrenci_kayit.dart';
import 'package:qr_attendance_project/screen/ogretmen/ogretmen_ana_ekran.dart';
import 'package:qr_attendance_project/screen/ogretmen/ogretmen_ders_detay.dart';
import 'package:qr_attendance_project/screen/ogretmen/ogretmen_ders_ekle.dart';
import 'package:qr_attendance_project/screen/ogretmen/ogretmen_giris.dart';
import 'package:qr_attendance_project/screen/ogretmen/yoklama_detay.dart';
import 'package:qr_attendance_project/screen/ogretmen/yoklama_detay_iskelet.dart';
import 'package:qr_attendance_project/screen/splash_screen.dart';
import 'package:qr_attendance_project/screen/giris.dart';
import 'package:qr_attendance_project/services/locator.dart';
import 'package:qr_attendance_project/theme/theme.dart';
import 'package:qr_attendance_project/theme/util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Retrieves the default theme for the platform
    //TextTheme textTheme = Theme.of(context).textTheme;

    // Use with Google Fonts package to use downloadable fonts
    TextTheme textTheme = createTextTheme(context, "Roboto", "Roboto Slab");

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
        title: 'Flutter Demo',
        theme: themeProvider.isDarkMode ? theme.light() : theme.dark(),
        themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        home: Giris());
  }
}
