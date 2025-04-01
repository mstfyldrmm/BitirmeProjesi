import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_attendance_project/custom/app_bar.dart';
import 'package:qr_attendance_project/custom/custom_loading.dart';
import 'package:qr_attendance_project/custom/custom_text_field.dart';
import 'package:qr_attendance_project/custom/icon_creater.dart';
import 'package:qr_attendance_project/custom/login_button.dart';
import 'package:qr_attendance_project/custom/widget_sizes.dart';
import 'package:qr_attendance_project/provider/theme_provider.dart';
import 'package:qr_attendance_project/screen/ogretmen/ogretmen_ana_ekran.dart';

class OgretmenDersEkle extends StatelessWidget with IconCreater {
  const OgretmenDersEkle({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    TextEditingController dersAd = TextEditingController();
    TextEditingController dersKod = TextEditingController();
    TextEditingController dersBolum = TextEditingController();
    return Scaffold(
      appBar: CustomAppBar(themeProvider, 'Ders Oluşturma'),
      body: Padding(
        padding: WidgetSizes.normalPadding.value,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Center(
                  child: Image.asset(
                'assets/icons/education.png',
                color: Theme.of(context).unselectedWidgetColor,
              )),
            ),
            Expanded(
              child: CustomTextField(
                  title: 'Dersin Adı',
                  icon: iconCreaterColor('assets/icons/signature.png', context),
                  controller: dersAd),
            ),
            Expanded(
              child: CustomTextField(
                  title: 'Dersin Kodu',
                  icon: iconCreaterColor(
                      'assets/icons/license-plate.png', context),
                  controller: dersKod),
            ),
            Expanded(
              child: CustomTextField(
                  title: 'Dersin Bölümü',
                  icon:
                      iconCreaterColor('assets/icons/department.png', context),
                  controller: dersBolum),
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: iconCreaterColor(
                        'assets/icons/upload-file.png', context)),
                Text(
                  'Öğrenci Listesinin\n Exel Dosyasını Yükle',
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            )),
            LoginButton(
              title: 'Ders Kaydını Tamamla',
              func: () {
                showCustomLoadingDialog(context, OgretmenAnaEkran());
              },
            )
          ],
        ),
      ),
    );
  }
}
