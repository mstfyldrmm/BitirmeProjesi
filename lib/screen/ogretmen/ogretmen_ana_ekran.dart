import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_attendance_project/custom/app_bar.dart';
import 'package:qr_attendance_project/custom/custom_ogrenci_appBar.dart';
import 'package:qr_attendance_project/custom/custom_text_field.dart';
import 'package:qr_attendance_project/custom/icon_creater.dart';
import 'package:qr_attendance_project/custom/navigate_to_widget.dart';
import 'package:qr_attendance_project/custom/widget_sizes.dart';
import 'package:qr_attendance_project/provider/theme_provider.dart';

import 'package:qr_attendance_project/screen/ogretmen/ogretmen_ders_detay.dart';
import 'package:qr_attendance_project/screen/ogretmen/ogretmen_ders_ekle.dart';
import 'package:qr_attendance_project/screen/ogretmen/ogretmen_drawer.dart';

class OgretmenAnaEkran extends StatefulWidget {
  const OgretmenAnaEkran({super.key});

  @override
  State<OgretmenAnaEkran> createState() => _OgretmenAnaEkranState();
}

class _OgretmenAnaEkranState extends State<OgretmenAnaEkran>
    with NavigatorManager, IconCreater {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    TextEditingController searchController = TextEditingController();
    List<String> dersler = [
      'Matematik I',
      'Matematik II',
      'Fizik I',
      'Fizik II',
      'Elektrik Devreleri',
      'Temel Bilgisayar Bilimleri',
      'Veritabanı Yönetim Sistemleri',
      'Algoritmalar ve Veri Yapıları',
      'Yazılım Mühendisliği',
      'Sayısal Mantık ve Dijital Tasarım',
      'Bilgisayar Organizasyonu ve Mimarisi',
      'İngilizce',
      'İstatistik ve Olasılık',
      'Sistem Analizi ve Tasarımı',
      'Ağ Temelleri',
      'İleri Seviye Programlama',
      'Yapay Zeka',
      'İşletim Sistemleri',
      'Mobil Programlama',
      'Makine Öğrenmesi',
    ];

    return Scaffold(
      drawer: OgretmenDrawer(),
      appBar: customAppBar(context, 'E-YOKLAMA'),
      body: Padding(
        padding: WidgetSizes.normalPadding.value,
        child: Column(
          children: [
            CustomTextField(
              title: 'Derslerimi Ara',
              icon: Icon(Icons.search),
              controller: searchController,
            ),
            ogretmenDerslerCreater(dersler),
          ],
        ),
      ),
      floatingActionButton: fabCreater(context),
    );
  }

  FloatingActionButton fabCreater(BuildContext context) {
    return FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: iconCreaterColor('assets/icons/add-database.png', context),
        onPressed: () {
          navigateToWidget(context, OgretmenDersEkle());
        });
  }

  Expanded ogretmenDerslerCreater(List<String> dersler) {
    return Expanded(
        child: ListView.builder(
      itemCount: dersler.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 3),
          elevation: 10,
          shadowColor: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            contentPadding: WidgetSizes.normalPadding.value,
            title: Text(dersler[index],
                style: Theme.of(context).textTheme.titleMedium),
            subtitle: Text(
              "Bilgisayar Mühendisliği",
            ),
            trailing: iconCreaterColor('assets/icons/teacher.png', context),
            onTap: () {
              navigateToNormalWidget(context, OgretmenDersDetay());
            },
          ),
        );
      },
    ));
  }
}
