import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:qr_attendance_project/custom/app_bar.dart';
import 'package:qr_attendance_project/custom/custom_ogrenci_appBar.dart';
import 'package:qr_attendance_project/custom/custom_text_field.dart';
import 'package:qr_attendance_project/custom/icon_creater.dart';
import 'package:qr_attendance_project/custom/navigate_to_widget.dart';
import 'package:qr_attendance_project/custom/widget_sizes.dart';
import 'package:qr_attendance_project/model/ders.dart';
import 'package:qr_attendance_project/provider/theme_provider.dart';
import 'package:qr_attendance_project/screen/student/student_lesson_detail/student_lesson_detail_screen.dart';
import 'package:qr_attendance_project/screen/student/ogrenci_ders_kayit_talep.dart';
import 'package:qr_attendance_project/screen/student/ogrenci_drawer.dart';
import 'package:qr_attendance_project/screen/student/student_main/components/fab_menu.dart';
import 'package:qr_attendance_project/screen/student/student_main/components/student_drawer.dart';

class StudentMainScreen extends StatefulWidget {
  const StudentMainScreen({super.key});

  @override
  _OgrenciAnaEkranState createState() => _OgrenciAnaEkranState();
}

class _OgrenciAnaEkranState extends State<StudentMainScreen>
    with NavigatorManager, IconCreater {
  bool _isExpanded = false; // Menü açık/kapalı kontrolü

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    TextEditingController searchController = TextEditingController();
    List<Ders> dersler = [
      Ders("BIL301", "Mikroişlemciler", "Erhan Ergün",
          "Bilgisayar Mühendisliği", 100),
      Ders("BIL302", "Veri Yapıları", "Ahmet Yılmaz", "Bilgisayar Mühendisliği",
          90),
      Ders("BIL303", "Sayısal Mantık", "Mehmet Demir",
          "Bilgisayar Mühendisliği", 60),
      Ders("BIL304", "İşletim Sistemleri", "Zeynep Kaya",
          "Bilgisayar Mühendisliği", 70),
      Ders("BIL305", "Bilgisayar Mimarisi", "Ali Can",
          "Bilgisayar Mühendisliği", 80),
      Ders("BIL306", "Veritabanı Sistemleri", "Fatma Aydın",
          "Bilgisayar Mühendisliği", 90),
      Ders("BIL307", "Gömülü Sistemler", "Emre Şahin",
          "Bilgisayar Mühendisliği", 110),
      Ders("BIL308", "Siber Güvenlik", "Ayşe Kurt", "Bilgisayar Mühendisliği",
          120),
      Ders("BIL309", "Yapay Zeka", "Murat Çelik", "Bilgisayar Mühendisliği",
          130),
      Ders("BIL310", "Makine Öğrenmesi", "Selin Doğan",
          "Bilgisayar Mühendisliği", 150),
    ];

    return Scaffold(
      drawer: StudentDrawer(),
      appBar: customAppBar(context, 'Derslerim'),
      body: Padding(
        padding: WidgetSizes.normalPadding.value,
        child: Column(
          children: [
            CustomTextField(
              title: 'Derslerimi Ara',
              icon: Icon(Icons.search),
              controller: searchController,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return studentLessonCard(context, dersler, index);
                },
                itemCount: dersler.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FabMenu(
        isExpanded: _isExpanded,
      ),
    );
  }

  Card studentLessonCard(BuildContext context, List<Ders> dersler, int index) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: EdgeInsets.only(top: 20, left: 20, right: 20),
        leading: iconCreaterColor('assets/icons/chalkboard.png', context),
        onTap: () {
          navigateToWidget(context, StudentLessonDetailScreen());
        },
        title: Text(dersler[index].dersAdi,
            style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(
          "\n${dersler[index].dersHoca}\n${dersler[index].bolum}\n",
        ),
        trailing: Text(dersler[index].dersKodu),
      ),
    );
  }
}
