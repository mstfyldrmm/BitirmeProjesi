import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_attendance_project/custom/custom_ogrenci_appBar.dart';
import 'package:qr_attendance_project/custom/icon_creater.dart';
import 'package:qr_attendance_project/custom/navigate_to_widget.dart';
import 'package:qr_attendance_project/custom/widget_sizes.dart';
import 'package:qr_attendance_project/provider/theme_provider.dart';
import 'package:qr_attendance_project/screen/student/ogrenci_drawer.dart';
import 'package:qr_attendance_project/screen/student/student_main/components/student_drawer.dart';
import 'package:qr_attendance_project/screen/student/student_sign_in.dart/student_sign_in_screen.dart';

class StudentAccountScreen extends StatefulWidget {
  const StudentAccountScreen({super.key});

  @override
  State<StudentAccountScreen> createState() => _OgrenciHesabimState();
}

class _OgrenciHesabimState extends State<StudentAccountScreen>
    with IconCreater, NavigatorManager {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = false;

    void onThemeChanged() {
      setState(() {
        isDarkMode = isDarkMode;
      });
    }

    return Scaffold(
      appBar: customAppBar(context, 'Hesabım'),
      drawer: StudentDrawer(),
      body: Padding(
        padding: WidgetSizes.normalPadding.value,
        child: Column(
          children: [
            Expanded(
                flex: 4,
                child: iconCreaterColor('assets/icons/gear.png', context)),
            menuCreater(context, 'Şifremi Güncelle',
                'assets/icons/mobile-password.png', () {}),
            Expanded(
                child: Card(
              child: ListTile(
                  contentPadding: WidgetSizes.smallPadding.value,
                  title: Text(
                    'Temayı Değiştir',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  onTap: () {
                    themeProvider.toggleTheme();
                    onThemeChanged();
                  },
                  trailing: isDarkMode
                      ? iconCreaterColor(
                          'assets/icons/sun.png', context) // Karanlık mod (🌙)
                      : iconCreaterColor('assets/icons/moon.png', context)),
            )),
            menuCreater(context, 'Çıkış Yap', 'assets/icons/logout.png', () {
              navigateToNoBackWidget(context, StudentSignInScreen());
            }),
            Spacer()
          ],
        ),
      ),
    );
  }

  Expanded menuCreater(BuildContext context, String title, String iconPath,
      VoidCallback onPressed) {
    return Expanded(
        child: Card(
      child: ListTile(
        onTap: onPressed,
        contentPadding: WidgetSizes.smallPadding.value,
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        trailing: IconButton(
            onPressed: onPressed, icon: iconCreaterColor(iconPath, context)),
      ),
    ));
  }
}
