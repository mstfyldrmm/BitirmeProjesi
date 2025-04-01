import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_attendance_project/custom/app_bar.dart';
import 'package:qr_attendance_project/custom/circularPercentWidget.dart';
import 'package:qr_attendance_project/custom/icon_creater.dart';
import 'package:qr_attendance_project/custom/navigate_to_widget.dart';
import 'package:qr_attendance_project/custom/widget_sizes.dart';
import 'package:qr_attendance_project/model/ders.dart';
import 'package:qr_attendance_project/provider/theme_provider.dart';
import 'package:qr_attendance_project/screen/ogretmen/ders_bilgi_ekrani.dart';
import 'package:qr_attendance_project/screen/ogretmen/yoklama_detay.dart';

class OgretmenDersDetay extends StatefulWidget {
  const OgretmenDersDetay({super.key});

  @override
  State<OgretmenDersDetay> createState() => _OgretmenDersDetayState();
}

class _OgretmenDersDetayState extends State<OgretmenDersDetay>
    with NavigatorManager, IconCreater {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String date =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    Ders ders = Ders('bil301', 'Mikroişlemciler', 'Erhan Ergün',
        'Bilgisayar Mühendisliği', 120);
    bool isStarted = false;

    void _toggleButton() {
      setState(() {
        isStarted = !isStarted;
      });

      if (isStarted) {
        // Start butonuna basıldığında çalışacak işlemler
        debugPrint("Başlatıldı!");
      } else {
        // Stop butonuna basıldığında çalışacak işlemler
        debugPrint("Durduruldu!");
      }
    }

    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(themeProvider, ders.dersAdi),
      body: Padding(
        padding: WidgetSizes.normalPadding.value,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                flex: 2,
                child: DersBilgiKarti(
                  ders: ders,
                )),
            ogretmenButtons(context),
            katilimDurumu(date)
          ],
        ),
      ),
    );
  }

  Expanded katilimDurumu(String date) {
    return Expanded(
              flex: 2,
              child: PageView.builder(
                  itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        date,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      circularPercentWidget(
                        context,
                        0.5,
                        "%50\nKatılım",
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            'assets/icons/file.png',
                            color: Theme.of(context).hintColor,
                          ))
                    ],
                  ),
                );
              }));
  }

  Expanded ogretmenButtons(BuildContext context) {
    return Expanded(
              flex: 2,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              elevation: 10,
                              shape: CircleBorder(),
                            ),
                            child: iconCreaterNoColor(
                                'assets/icons/calendar-with-check.png',
                                context),
                          ),
                          Text('Yoklama Başlat',
                              style: Theme.of(context).textTheme.titleMedium)
                        ],
                      ),
                      VerticalDivider(
                        thickness: 2, // Çizginin kalınlığı
                        width: 10, // Butonlar arası boşluk
                        // Çizginin rengi
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              navigateToNormalWidget(context, YoklamaDetay());
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 10,
                              shape: CircleBorder(),
                            ),
                            child: iconCreaterNoColor(
                                'assets/icons/calendar.png', context),
                          ),
                          Text(
                            'Geçmiş Yoklamalar',
                            style: Theme.of(context).textTheme.titleMedium,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ));
  }
}
