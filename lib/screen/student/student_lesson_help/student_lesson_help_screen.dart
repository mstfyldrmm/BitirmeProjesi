import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_attendance_project/custom/icon_creater.dart';
import 'package:qr_attendance_project/custom/login_button.dart';
import 'package:qr_attendance_project/custom/navigate_to_widget.dart';
import 'package:qr_attendance_project/custom/widget_sizes.dart';
import 'package:qr_attendance_project/screen/student/student_my_lessons/student_my__lessons_screen.dart';

class StudentLessonHelpScreen extends StatefulWidget with NavigatorManager {
  StudentLessonHelpScreen({super.key});

  @override
  State<StudentLessonHelpScreen> createState() => _StudentLessonHelpScreenState();
}

class _StudentLessonHelpScreenState extends State<StudentLessonHelpScreen>
    with NavigatorManager, TickerProviderStateMixin, IconCreater {
  late AnimationController _controller;

  @override
  void dispose() {
    _controller.dispose(); // Controller'ı temizle
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3), // Animasyon süresi
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Animasyon tamamlandığında yönlendirme yap
        navigateToNoBackWidget(context, StudentMyLessonsScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String _selectedDers = '';
    String _aciklama = 'Lütfen bir seçenek belirleyin';
    List<String> dersler = [
      "BIL301 - Mikroişlemciler",
      "BIL302 - Veri Yapıları",
      "BIL303 - Sayısal Mantık",
      "BIL304 - İşletim Sistemleri",
    ];

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: WidgetSizes.normalPadding.value,
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: iconCreaterColor('assets/icons/chat.png', context)),
            Expanded(
                flex: 2,
                child: dropDownCreater(_aciklama, _selectedDers, dersler)),
            Expanded(
              child: LoginButton(
                title: 'Kayıt Talebi Oluştur',
                func: () {
                  setState(() {
                    _controller.forward(); // Animasyonu başlat
                  });
                  showDialog(
                    context: context,
                    barrierDismissible:
                        false, // Dialog dışında bir yere tıklanarak kapatılmasın
                    builder: (BuildContext context) {
                      return dialogWidget(context);
                    },
                  );
                },
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }

  Dialog dialogWidget(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width, // Genişliği ayarlayın
        height: 300, // Yüksekliği ayarlayın
        padding: WidgetSizes.normalPadding.value,
        child: Center(
          child: LottieBuilder.asset(
            'assets/lottie/big-send.json',
            controller: _controller,
            onLoaded: (composition) {
              _controller.duration = composition.duration;
            },
            fit: BoxFit.contain, // Animasyonu kapsayan alan
          ),
        ),
      ),
    );
  }

  DropdownButtonFormField<String> dropDownCreater(
      String _aciklama, String _selectedDers, List<String> dersler) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      hint: Text(_aciklama),
      value: _selectedDers.isNotEmpty ? _selectedDers : null,
      items: dersler.map((ders) {
        return DropdownMenuItem<String>(
          value: ders,
          child: Text(ders),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedDers = value!;
        });
      },
      validator: (value) =>
          value == null || value.isEmpty ? 'Lütfen bir ders seçin' : null,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
    );
  }
}
