import 'package:qr_attendance_project/export.dart';

class StudentRegisterScreen extends StatefulWidget {
  const StudentRegisterScreen({super.key});

  @override
  State<StudentRegisterScreen> createState() => _StudentRegisterScreenState();
}

class _StudentRegisterScreenState extends State<StudentRegisterScreen>
    with NavigatorManager {
  late final StudentRegisterView _vm;

  @override
  void initState() {
    _vm = StudentRegisterView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController surname = TextEditingController();
    TextEditingController mail = TextEditingController();
    TextEditingController sifre = TextEditingController();

    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: CustomAppBar(context,
          title: LocaleKeys.studentTitle_registerTitle.locale),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: WidgetSizes.normalPadding.value,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OmuLogo(),
                emptyWidget(),
                Text(
                  LocaleKeys.register_contents.locale,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                emptyWidget(),
                ValueListenableBuilder(
                  valueListenable: _vm.studentName,
                  builder: (_, __, ___) {
                    return CustomTextField(
                      title: LocaleKeys.register_name.locale,
                      icon: Icon(Icons.person_4_outlined),
                      validator: _vm.validateTextField,
                      controller: name,
                      onChanged: (value) {
                        _vm.studentName.value = value;
                      },
                    );
                  },
                ),
                emptyWidget(),
                ValueListenableBuilder(
                  valueListenable: _vm.studentSurname,
                  builder: (_, __, ___) {
                    return CustomTextField(
                      title: LocaleKeys.register_surname.locale,
                      validator: _vm.validateTextField,
                      icon: Icon(Icons.person_4_outlined),
                      controller: surname,
                      onChanged: (value) {
                        _vm.studentSurname.value = value;
                      },
                    );
                  },
                ),
                emptyWidget(),
                ValueListenableBuilder(
                  valueListenable: _vm.studentMail,
                  builder: (_, __, ___) {
                    return CustomTextField(
                      keyboardType: TextInputType.emailAddress,
                      title: LocaleKeys.register_mail.locale,
                      icon: Icon(Icons.mail_outline_outlined),
                      controller: mail,
                      validator: _vm.validateEmail,
                      onChanged: (value) {
                        _vm.studentMail.value = value;
                      },
                    );
                  },
                ),
                emptyWidget(),
                ValueListenableBuilder(
                  valueListenable: _vm.studentPassword,
                  builder: (_, __, ___) {
                    return CustomTextField(
                        title: LocaleKeys.register_password.locale,
                        validator: _vm.validatePassword,
                        icon: Icon(Icons.visibility_outlined),
                        onChanged: (value) {
                          _vm.studentPassword.value = value;
                        },
                        controller: sifre);
                  },
                ),
                emptyWidget(),
                CustomButton(
                  title: LocaleKeys.register_register.locale,
                  onPress: () async {
                    await registerCheckMethod(_formKey, context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerCheckMethod(
      GlobalKey<FormState> _formKey, BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      bool isOkey = await _vm.registerStudent();
      if (isOkey) {
        showCustomSnackBar(
            context, LocaleKeys.register_successMessage.locale, false);
        navigateToNoBackWidget(
            context,
            StudentLoginScreen(
              userType: 'student',
            ));
      }
    }
  }

  SizedBox emptyWidget() {
    return SizedBox(
      height: 10,
    );
  }
}
