import 'package:qr_attendance_project/export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with NavigatorManager, IconCreater {
  late final SplashView _vm;
  @override
  void initState() {
    _vm = SplashView();
    serviceLocalStorage.getInstance();
    waitAndNavigate(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CustomIconCreator(
              iconPath: 'assets/icons/logo.png',
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                LocaleKeys.appTitle.locale,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> waitAndNavigate(BuildContext context) async {
    await Future.delayed(
      const Duration(seconds: 3),
      () {
        if (_vm.getUserType() == UserType.student.value) {
          _vm.isLoggedInEmailPassword()
              ? navigateToNoBackWidget(
                  context,
                  StudentDrawerContent(
                    userId: _vm.getUserIdStudent(),
                  ),
                )
              : navigateToNoBackWidget(
                  context,
                  StartScreen(),
                );
        } else {
          _vm.isLoggedInEmailPassword()
              ? navigateToNoBackWidget(
                  context,
                  TeacherDrawerContent(
                    userId: '8lyQaKLxABVvbwuWRqjygj3Lr4i1',
                  ))
              : navigateToNoBackWidget(
                  context,
                  StartScreen(),
                );
        }
      },
    );
  }
}
