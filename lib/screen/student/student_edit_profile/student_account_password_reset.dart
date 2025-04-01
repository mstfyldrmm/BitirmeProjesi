import 'package:qr_attendance_project/export.dart';


class StudentAccountPasswordReset extends StatefulWidget {
  StudentAccountPasswordReset({super.key, this.mailAdress});
  String? mailAdress;

  @override
  State<StudentAccountPasswordReset> createState() =>
      _StudentAccountPasswordResetState();
}

class _StudentAccountPasswordResetState
    extends State<StudentAccountPasswordReset> {
  late final StudentEditProfileView _vm;

  @override
  void initState() {
    _vm = StudentEditProfileView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: CustomAppBar(context,
          title: LocaleKeys.studentTitle_passwordResetTitle.locale),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: WidgetSizes.normalPadding.value,
            child: Column(
              children: [
                OmuLogo(),
                spaceWidget(height: 100),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.mail_outline_outlined),
                    title: Text(widget.mailAdress ?? ''),
                  ),
                ),
                spaceWidget(height: 50),
                LoginButton(
                  title: LocaleKeys.passwordReset_reset.locale,
                  func: () {
                    _vm.sendPasswordResetLink(widget.mailAdress!, context);
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
