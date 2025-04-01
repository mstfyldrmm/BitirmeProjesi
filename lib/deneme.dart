import 'package:flutter/material.dart';
import 'package:qr_attendance_project/custom/icon_creater.dart';
import 'package:qr_attendance_project/custom/widget_sizes.dart';
import 'package:qr_attendance_project/screen/student/student_account/companent/container-widget.dart';
import 'package:qr_attendance_project/screen/student/student_account/companent/list_tile_widget.dart';

class Deneme extends StatelessWidget with IconCreater {
  const Deneme({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      children: [
        ContainerWidget(),
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Text(
            'Mustafa Yıldırım',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            '20060392@stu.omu.edu.tr',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Card(
            child: Column(
              children: [
                ListTileWidget(
                    imagePath: 'assets/icons/translation.png',
                    title: 'Language',
                    trailingWidget: TextButton(
                        onPressed: () {},
                        child: Text(
                          'English',
                          style: Theme.of(context).textTheme.titleMedium,
                        ))),
                ListTileWidget(
                    imagePath: 'assets/icons/morning.png',
                    title: 'Theme',
                    trailingWidget: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Light Mode',
                          style: Theme.of(context).textTheme.titleMedium,
                        ))),
              ],
            ),
          ),
        ),
        Padding(
          padding: WidgetSizes.normalPadding.value,
          child: Card(
            child: Column(
              children: [
                ListTileWidget(
                    imagePath: 'assets/icons/user-edit.png',
                    title: 'Profili Düzenle',
                    trailingWidget: IconButton(
                        onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))),
                ListTileWidget(
                    imagePath: 'assets/icons/reset-password.png',
                    title: 'Şifremi Değiştir',
                    trailingWidget: IconButton(
                        onPressed: () {}, icon: Icon(Icons.arrow_forward_ios)))
              ],
            ),
          ),
        )
      ],
    ));
  }
}
