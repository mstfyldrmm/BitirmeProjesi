import 'package:qr_attendance_project/export.dart';


class StudentAccountScreen extends StatefulWidget {
  StudentAccountScreen({super.key, this.studentModelId});
  String? studentModelId;

  @override
  State<StudentAccountScreen> createState() => _StudentAccountScreenState();
}

class _StudentAccountScreenState extends State<StudentAccountScreen>
    with IconCreater, NavigatorManager {
  late final StudentAccountView _vm;

  @override
  void initState() {
    super.initState();
    _vm = StudentAccountView();
    _vm.getStudentInfo(widget.studentModelId!);
    serviceLocalStorage.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ContainerWidget(),
            ValueListenableBuilder(
              valueListenable: _vm.studentModel,
              builder: (_, __, ___) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Text(
                        "${_vm.studentModel.value?.studentName?.toUpperCase() ?? ""} ${_vm.studentModel.value?.studentSurname?.toUpperCase() ?? ""}",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        _vm.studentModel.value?.mailAddress ?? '',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                );
              },
            ),
            Padding(
              padding: WidgetSizes.normalPadding.value,
              child: Card(
                child: Column(
                  children: [
                    ListTileWidget(
                      imagePath: 'assets/icons/user-edit.png',
                      title: LocaleKeys.studentAccount_editProfile.locale,
                      trailingWidget: IconButton(
                        onPressed: () => navigateToWidget(
                          context,
                          StudentEditProfileScreen(
                            studentId: widget.studentModelId,
                          ),
                        ),
                        icon: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    ListTileWidget(
                      imagePath: 'assets/icons/reset-password.png',
                      title: LocaleKeys.studentAccount_changePassword.locale,
                      trailingWidget: IconButton(
                        onPressed: () => navigateToWidget(
                          context,
                          StudentAccountPasswordReset(
                            mailAdress: _vm.studentModel.value!.mailAddress,
                          ),
                        ),
                        icon: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Card(
                child: Column(
                  children: [
                    ValueListenableBuilder(
                        valueListenable: _vm.deviceLanguage,
                        builder: (_, __, ___) {
                          return ListTileWidget(
                            imagePath: 'assets/icons/translation.png',
                            title: LocaleKeys.studentAccount_language.locale,
                            trailingWidget: TextButton(
                              onPressed: () {},
                              child: Text(
                                _vm.deviceLanguage.value.toUpperCase(),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          );
                        }),
                    ValueListenableBuilder(
                      valueListenable: _vm.isDarkMode,
                      builder: (_, __, ___) {
                        return ListTileWidget(
                          imagePath: 'assets/icons/morning.png',
                          title: LocaleKeys.studentAccount_theme.locale,
                          trailingWidget: TextButton(
                            onPressed: () {
                              themeProvider.toggleTheme();
                              _vm.onThemeChanged();
                            },
                            child: Text(
                              _vm.isDarkMode.value ? 'Dark Mode' : 'Light Mode',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        );
                      },
                    ),
                    ListTileWidget(
                      imagePath: 'assets/icons/logout.png',
                      title: LocaleKeys.studentAccount_logOut.locale,
                      trailingWidget: IconButton(
                          onPressed: () async {
                            await _vm.logOutStudent()
                                ? navigateToNoBackWidget(
                                    context,
                                    StartScreen(),
                                  )
                                : showToast(
                                    LocaleKeys
                                        .errorCode_login_defaultMessage.locale,
                                    isError: true,
                                  );
                          },
                          icon: CustomIconCreator(
                              iconPath: 'assets/icons/shutdown.png')),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
