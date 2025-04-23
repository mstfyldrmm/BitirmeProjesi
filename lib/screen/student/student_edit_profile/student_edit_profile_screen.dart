import 'package:qr_attendance_project/export.dart';


class StudentEditProfileScreen extends StatefulWidget {
  StudentEditProfileScreen({super.key, this.studentId});
  String? studentId;

  @override
  State<StudentEditProfileScreen> createState() =>
      _StudentEditProfileScreenState();
}

class _StudentEditProfileScreenState extends State<StudentEditProfileScreen>
    with NavigatorManager {
  late final StudentEditProfileView _vm;

  @override
  void initState() {
    _vm = StudentEditProfileView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController surname = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: CustomAppBar(context,
          title: LocaleKeys.account_editProfile.locale),
      body: Form(
        key: formKey,
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
                CustomButton(
                  title: LocaleKeys.account_updateButton.locale,
                  onPress: () {
                    updateCheckMethod(formKey, context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateCheckMethod(
      GlobalKey<FormState> _formKey, BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      bool isOkey = await _vm.updateStudentInfo(widget.studentId!);
      if (isOkey) {
        navigateToNormalWidget(
            context,
            StudentDrawerContent(
              userId: widget.studentId!,
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
