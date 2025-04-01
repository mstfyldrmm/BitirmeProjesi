// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:qr_attendance_project/custom/app_bar.dart';
// import 'package:qr_attendance_project/custom/clip_oval.dart';
// import 'package:qr_attendance_project/custom/custom_loading.dart';
// import 'package:qr_attendance_project/custom/custom_text_field.dart';
// import 'package:qr_attendance_project/custom/login_button.dart';
// import 'package:qr_attendance_project/custom/navigate_to_widget.dart';
// import 'package:qr_attendance_project/custom/widget_sizes.dart';
// import 'package:qr_attendance_project/provider/theme_provider.dart';
// import 'package:qr_attendance_project/screen/student/student_sign_in.dart/student_sign_in_screen.dart';
// import 'package:qr_attendance_project/services/locator.dart';
// import 'package:qr_attendance_project/services/ogrenci_services.dart';

// class OgrenciKayit extends StatelessWidget with NavigatorManager {
//   const OgrenciKayit({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     TextEditingController name = TextEditingController();
//     TextEditingController surname = TextEditingController();
//     TextEditingController mail = TextEditingController();
//     TextEditingController sifre = TextEditingController();

//     return Scaffold(
//       appBar: CustomAppBar(themeProvider, OgrenciKayitString().title),
//       body: Padding(
//         padding: WidgetSizes.normalPadding.value,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             OmuLogo(
//               height: 140,
//             ),
//             Text(
//               OgrenciKayitString().icerik,
//               style: Theme.of(context).textTheme.titleLarge,
//             ),
//             Text(
//               OgrenciKayitString().subIcerik,
//               textAlign: TextAlign.center,
//             ),
//             CustomTextField(
//                 title: 'Ad',
//                 icon: Icon(Icons.person_4_outlined),
//                 controller: name),
//             CustomTextField(
//                 title: 'Soyad',
//                 icon: Icon(Icons.person_4_outlined),
//                 controller: surname),
//             CustomTextField(
//                 title: 'Okul Mail Adresi',
//                 icon: Icon(Icons.mail_outline_outlined),
//                 controller: mail),
//             CustomTextField(
//                 title: 'Şifre',
//                 icon: Icon(Icons.visibility_outlined),
//                 controller: sifre),
//             LoginButton(
//               title: 'Kayıt Ol',
//               func: () {
//                 locator.get<OgrenciServices>().registerStudent(mail: mail.text, name: name.text, password: sifre.text, surname: surname.text, numara: mail.text);
//                 showCustomLoadingDialog(context, OgrenciGiris());
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class OgrenciKayitString {
//   final String title = "'Öğrenci Kayıt'";
//   final String icerik = "Profilinizi Oluşturun";
//   final String subIcerik =
//       '"Sınıfta mısın, yoksa listede yok musun? 📢 E-Yoklama ile her an kayıttasın!" 🚀';
// }
