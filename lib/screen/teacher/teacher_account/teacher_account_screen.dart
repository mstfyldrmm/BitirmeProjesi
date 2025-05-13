import 'package:qr_attendance_project/export.dart';

class TeacherAccountScreen extends StatefulWidget {
  TeacherAccountScreen({super.key, this.teacherModelId});
  String? teacherModelId;

  @override
  State<TeacherAccountScreen> createState() => _TeacherAccountScreenState();
}

class _TeacherAccountScreenState extends State<TeacherAccountScreen>
    with IconCreater, NavigatorManager {
  late final TeacherAccountView _vm;

  @override
  void initState() {
    super.initState();
    _vm = TeacherAccountView();
    _vm.getTeacherInfo(widget.teacherModelId!);
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
              valueListenable: _vm.teacherModel,
              builder: (_, __, ___) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Text(
                        "${_vm.teacherModel.value?.teacherName?.toUpperCase() ?? ""} ${_vm.teacherModel.value?.teacherSurname?.toUpperCase() ?? ""}",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        _vm.teacherModel.value?.teacherMailAdress ?? '',
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
                      title: LocaleKeys.account_editProfile.locale,
                      trailingWidget: IconButton(
                        onPressed: () => navigateToWidget(
                          context,
                          TeacherEditProfileScreen(
                            teacherId: widget.teacherModelId,
                          ),
                        ),
                        icon: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    ListTileWidget(
                      imagePath: 'assets/icons/reset-password.png',
                      title: LocaleKeys.account_changePassword.locale,
                      trailingWidget: IconButton(
                        onPressed: () => navigateToWidget(
                          context,
                          StudentPasswordResetScreen(
                            title: LocaleKeys
                                .teacherTitle_passwordResetTitle.locale,
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
                            title: LocaleKeys.account_language.locale,
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
                          title: LocaleKeys.account_theme.locale,
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
                      title: LocaleKeys.account_logOut.locale,
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
