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
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: WidgetSizes.normalPadding.value,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Spacer(),
                  ClipOval(
                    child: Image.asset('assets/images/logo-3.png'),
                  ),
                  Spacer(),
                  Spacer(),
                  CustomButton(
                    title: LocaleKeys.studentTitle_loginTitle.locale,
                    onPress: () {
                      navigateToNormalWidget(
                        context,
                        StudentLoginScreen(
                          userType: 'student',
                        ),
                      );
                    },
                  ),
                  CustomButton(
                    title: LocaleKeys.teacherTitle_loginTitle.locale,
                    onPress: () {
                      navigateToNormalWidget(
                        context,
                        TeacherLoginScreen(
                          userType: 'teacher',
                        ),
                      );
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
