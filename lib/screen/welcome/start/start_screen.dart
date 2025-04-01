import 'package:qr_attendance_project/export.dart';

class StartScreen extends StatelessWidget with NavigatorManager {
  StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/images.jpeg',
              ),
              fit: BoxFit.cover)),
      child: Padding(
        padding: WidgetSizes.normalPadding.value,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Spacer(),
                  ClipOval(child: Image.asset('assets/images/logo-3.png')),
                  Spacer(),
                  Spacer(),
                  LoginButton(
                    title: LocaleKeys.studentTitle_loginTitle.locale,
                    func: () {
                      navigateToNormalWidget(context, StudentLoginScreen());
                    },
                  ),
                  LoginButton(
                    title: LocaleKeys.teacherTitle_loginTitle.locale,
                    func: () {
                      navigateToNormalWidget(context, TeacherLoginScreen());
                    },
                  )
                ],
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
