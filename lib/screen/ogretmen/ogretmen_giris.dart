import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_attendance_project/custom/app_bar.dart';
import 'package:qr_attendance_project/custom/clip_oval.dart';
import 'package:qr_attendance_project/custom/custom_text_field.dart';
import 'package:qr_attendance_project/custom/login_button.dart';
import 'package:qr_attendance_project/custom/navigate_to_widget.dart';
import 'package:qr_attendance_project/custom/widget_sizes.dart';
import 'package:qr_attendance_project/provider/theme_provider.dart';
import 'package:qr_attendance_project/screen/ogretmen/ogretmen_ana_ekran.dart';
import 'package:qr_attendance_project/screen/ogretmen/ogretmen_kayit.dart';

class OgretmenGiris extends StatelessWidget with NavigatorManager {
  const OgretmenGiris({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController mailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(themeProvider, 'Öğretmen Giriş'),
      body: Padding(
        padding: WidgetSizes.normalPadding.value,
        child: Column(
          children: [
            Spacer(),
            Expanded(
              flex: 2,
              child: Center(child: OmuLogo()),
            ),
            Spacer(),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomTextField(
                    controller: mailController,
                    icon: Icon(Icons.mail_rounded),
                    title: 'Mail Adresi',
                  ),
                  CustomTextField(
                    controller: passwordController,
                    icon: Icon(Icons.visibility_rounded),
                    title: 'Şifre',
                  ),
                ],
              ),
            ),
            LoginButton(
              title: 'Giriş Yap',
              func: () {
                navigateToNoBackWidget(context, OgretmenAnaEkran());
              },
            ),
            TextButton(onPressed: () {}, child: Text('Şifremi Unuttum?')),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Henüz Hesabın Yok Mu?'),
                TextButton(
                    onPressed: () {
                      navigateToNormalWidget(context, OgretmenKayit());
                    },
                    child: Text('Kayıt Ol'))
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
