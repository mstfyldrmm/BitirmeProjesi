import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_attendance_project/custom/custom_text_field.dart';
import 'package:qr_attendance_project/model/yoklama.dart';

class YoklamaDetayIskelet extends StatefulWidget {
  final Yoklama yoklama;

  const YoklamaDetayIskelet({Key? key, required this.yoklama})
      : super(key: key);

  @override
  _YoklamaEkraniState createState() => _YoklamaEkraniState();
}

class _YoklamaEkraniState extends State<YoklamaDetayIskelet> {
  late Map<Ogrenci, bool> katilimDurumu;

  @override
  void initState() {
    super.initState();
    katilimDurumu = {
      for (var ogrenci in ogrenciler)
        ogrenci: widget.yoklama.katilanOgrenciler!.contains(ogrenci)
    };
  }

  void toggleKatilim(Ogrenci ogrenci) {
    setState(() {
      katilimDurumu[ogrenci] = !katilimDurumu[ogrenci]!;
    });
  }

  String formatTarih(DateTime tarih) {
    return DateFormat('dd/MM/yyyy').format(tarih);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController ara = TextEditingController();
    String baslik =
        '${formatTarih(widget.yoklama.alinanTarih!)} Tarihli Yoklama';
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(baslik, style: Theme.of(context).textTheme.titleMedium),
          ),
          CustomTextField(
              title: 'Öğrenci Ara', icon: Icon(Icons.search), controller: ara),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  subTitleCreater(context, 'Numara'),
                  subTitleCreater(context, 'Ad'),
                  subTitleCreater(context, 'Soyad'),
                  subTitleCreater(context, 'Katılım Durumu')
                ],
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Card(
              child: ListView.builder(
                itemCount: ogrenciler.length,
                itemBuilder: (context, index) {
                  Ogrenci ogrenci = ogrenciler[index];
                  bool katildiMi = katilimDurumu[ogrenci] ?? false;

                  return Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(ogrenci.numara.toString()), // Numara
                        Text(ogrenci.adi), // Ad
                        Text(ogrenci.soyadi), // Soyad
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: katildiMi
                                  ? Image.asset('assets/icons/accept.png')
                                  : Image.asset('assets/icons/cancel.png'),
                              onPressed: () => toggleKatilim(ogrenci),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Text subTitleCreater(BuildContext context, String text) {
    return Text(text, style: Theme.of(context).textTheme.titleMedium);
  }
}
