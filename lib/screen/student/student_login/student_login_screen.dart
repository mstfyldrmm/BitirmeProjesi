import 'package:qr_attendance_project/export.dart';

class StudentLoginScreen extends StatefulWidget {
  const StudentLoginScreen({super.key});

  @override
  State<StudentLoginScreen> createState() => _StudentLoginScreenState();
}

class _StudentLoginScreenState extends State<StudentLoginScreen>
    with NavigatorManager {
  late final StudentSingInView _vm;

  @override
  void initState() {
    _vm = StudentSingInView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController mailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: CustomAppBar(context,
          title: LocaleKeys.studentTitle_loginTitle.locale),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: WidgetSizes.normalPadding.value,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(child: OmuLogo()),
                spacerMethod(height: 60),
                mailAndPasswordTextField(mailController, passwordController),
                spacerMethod(height: 10),
                LoginButton(
                  title: LocaleKeys.login_login.locale,
                  func: () {
                    _vm.loginStudent(_formKey, context);
                  },
                ),
                TextButton(
                    onPressed: () {
                      navigateToNormalWidget(
                          context, StudentPasswordResetScreen());
                    },
                    child: Text(LocaleKeys.login_forgotPassword.locale)),
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
              navigateToNormalWidget(context, StudentRegisterScreen());
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
          valueListenable: _vm.studentMail,
          builder: (_, __, ___) {
            return CustomTextField(
              validator: _vm.validateEmail,
              keyboardType: TextInputType.emailAddress,
              controller: mailController,
              icon: Icon(Icons.mail_rounded),
              title: LocaleKeys.login_mail.locale,
              onChanged: (value) {
                _vm.studentMail.value = value;
              },
            );
          },
        ),
        spacerMethod(height: 10),
        ValueListenableBuilder(
          valueListenable: _vm.studentPassword,
          builder: (_, __, ___) {
            return CustomTextField(
              validator: _vm.validatePassword,
              controller: passwordController,
              icon: Icon(Icons.visibility_rounded),
              title: LocaleKeys.login_password.locale,
              sifreGizle: true,
              onChanged: (value) {
                _vm.studentPassword.value = value;
              },
            );
          },
        ),
      ],
    );
  }
}
