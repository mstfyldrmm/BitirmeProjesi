import 'package:qr_attendance_project/export.dart';

class TeacherLoginScreen extends StatefulWidget {
  final String userType;
  const TeacherLoginScreen({
    super.key,
    required this.userType,
  });

  @override
  State<TeacherLoginScreen> createState() => _TeacherLoginScreenState();
}

class _TeacherLoginScreenState extends State<TeacherLoginScreen>
    with NavigatorManager {
  late final TeacherLoginView _vm;

  @override
  void initState() {
    _vm = TeacherLoginView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController mailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: CustomAppBar(
        context,
        title: LocaleKeys.teacherTitle_loginTitle.locale,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: WidgetSizes.normalPadding.value,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(child: OmuLogo()),
                spacerMethod(height: 60),
                mailAndPasswordTextField(
                  mailController,
                  passwordController,
                ),
                spacerMethod(height: 10),
                CustomButton(
                  title: LocaleKeys.login_login.locale,
                  onPress: () async {
                    await _vm.loginTeacher(formKey, context)
                        ? navigateToNoBackWidget(
                            context,
                            TeacherDrawerContent(
                              userId: _vm.getTeacherId(),
                            ),
                          )
                        : showToast(
                            "Bir hata oluştu",
                            isError: true,
                          );
                  },
                ),
                TextButton(
                  onPressed: () {
                    navigateToNormalWidget(
                      context,
                      StudentPasswordResetScreen(),
                    );
                  },
                  child: Text(LocaleKeys.login_forgotPassword.locale),
                ),
                textButtonsRow(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox spacerMethod({required double height}) => SizedBox(height: height);

  Row textButtonsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(LocaleKeys.login_noAccount.locale),
        TextButton(
            onPressed: () {
              navigateToNormalWidget(context, TeacherRegisterScreen());
            },
            child: Text(LocaleKeys.login_register.locale)),
      ],
    );
  }

  Column mailAndPasswordTextField(TextEditingController mailController,
      TextEditingController passwordController) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ValueListenableBuilder(
          valueListenable: _vm.teacherMail,
          builder: (_, __, ___) {
            return CustomTextField(
              validator: _vm.validateEmail,
              keyboardType: TextInputType.emailAddress,
              controller: mailController,
              icon: Icon(Icons.mail_rounded),
              title: LocaleKeys.login_mail.locale,
              onChanged: (value) {
                _vm.teacherMail.value = value;
              },
            );
          },
        ),
        spacerMethod(height: 10),
        ValueListenableBuilder(
          valueListenable: _vm.teacherPassword,
          builder: (_, __, ___) {
            return CustomTextField(
              validator: _vm.validatePassword,
              controller: passwordController,
              icon: Icon(Icons.visibility_rounded),
              title: LocaleKeys.login_password.locale,
              sifreGizle: true,
              onChanged: (value) {
                _vm.teacherPassword.value = value;
              },
            );
          },
        ),
      ],
    );
  }
}
