import 'package:qr_attendance_project/custom/custom_loading.dart';
import 'package:qr_attendance_project/export.dart';

class TeacherAddLessonScreen extends StatelessWidget with IconCreater {
  const TeacherAddLessonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    TextEditingController dersAd = TextEditingController();
    TextEditingController dersKod = TextEditingController();
    TextEditingController dersBolum = TextEditingController();
    return Scaffold(
      appBar: CustomAppBar(context, title: 'Ders Oluşturma'),
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
            Expanded(child: exelButton(context)),
            LoginButton(
              title: 'Ders Kaydını Tamamla',
              func: () {
                showCustomLoadingDialog(context, TeacherMainScreen());
              },
            )
          ],
        ),
      ),
    );
  }

  Row exelButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {},
            icon: iconCreaterColor('assets/icons/upload-file.png', context)),
        Text(
          'Öğrenci Listesinin\n Exel Dosyasını Yükle',
          style: Theme.of(context).textTheme.titleMedium,
        )
      ],
    );
  }
}
