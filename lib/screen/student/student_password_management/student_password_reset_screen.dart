import 'package:qr_attendance_project/export.dart';


class StudentPasswordResetScreen extends StatefulWidget {
  const StudentPasswordResetScreen({super.key});

  @override
  State<StudentPasswordResetScreen> createState() =>
      _StudentPasswordResetScreenState();
}

class _StudentPasswordResetScreenState
    extends State<StudentPasswordResetScreen> {
  late final StudentPasswordManagementView _vm;

  @override
  void initState() {
    _vm = StudentPasswordManagementView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: CustomAppBar(context, title: LocaleKeys.studentTitle_passwordResetTitle.locale),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: WidgetSizes.normalPadding.value,
            child: Column(
              children: [
                OmuLogo(),
                spaceWidget(height: 100),
                ValueListenableBuilder(
                    valueListenable: _vm.mailAdress,
                    builder: (_, __, ___) {
                      return CustomTextField(
                        title: LocaleKeys.passwordReset_mail.locale,
                        onChanged: (value) {
                          _vm.mailAdress.value = value;
                        },
                        controller: controller,
                        keyboardType: TextInputType.emailAddress,
                        validator: _vm.validateEmail,
                        icon: Icon(Icons.mail_rounded),
                      );
                    }),
                spaceWidget(height: 50),
                LoginButton(
                  title: LocaleKeys.passwordReset_reset.locale,
                  func: () {
                    _vm.sendEmailLink(_formKey, context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox spaceWidget({required double height}) => SizedBox(height: height);
}
