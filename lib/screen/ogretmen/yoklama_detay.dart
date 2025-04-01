import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_attendance_project/custom/app_bar.dart';
import 'package:qr_attendance_project/custom/widget_sizes.dart';
import 'package:qr_attendance_project/model/yoklama.dart';
import 'package:qr_attendance_project/provider/theme_provider.dart';
import 'package:qr_attendance_project/screen/ogretmen/yoklama_detay_iskelet.dart';

class YoklamaDetay extends StatelessWidget {
  const YoklamaDetay({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.transparent,
        onPressed: () {},
        child: Image.asset(YoklamaDetayString().iconPath),
      ),
      appBar: CustomAppBar(themeProvider, YoklamaDetayString().title),
      body: Padding(
        padding: WidgetSizes.normalPadding.value,
        child: PageView.builder(
          itemCount: yoklamaListesi.length,
          itemBuilder: (BuildContext context, int index) {
            return YoklamaDetayIskelet(
              yoklama: yoklamaListesi[index],
            );
          },
        ),
      ),
    );
  }
}

class YoklamaDetayString {
  String iconPath = 'assets/icons/pdf.png';
  String title = 'Yoklama Detay Ekranı';
}
