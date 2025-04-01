import 'package:qr_attendance_project/export.dart';


class TeacherEditProfileScreen extends StatefulWidget {
  TeacherEditProfileScreen({super.key, this.teacherId});
  String? teacherId;

  @override
  State<TeacherEditProfileScreen> createState() =>
      _TeacherEditProfileScreenState();
}

class _TeacherEditProfileScreenState extends State<TeacherEditProfileScreen>
    with NavigatorManager {
  late final TeacherEditProfileView _vm;

  @override
  void initState() {
    _vm = TeacherEditProfileView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController surname = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar:
          CustomAppBar(context, title: LocaleKeys.teacherAccount_title.locale),
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
                  valueListenable: _vm.teacherName,
                  builder: (_, __, ___) {
                    return CustomTextField(
                      title: LocaleKeys.register_name.locale,
                      icon: Icon(Icons.person_4_outlined),
                      validator: _vm.validateTextField,
                      controller: name,
                      onChanged: (value) {
                        _vm.teacherName.value = value;
                      },
                    );
                  },
                ),
                emptyWidget(),
                ValueListenableBuilder(
                  valueListenable: _vm.teacherSurname,
                  builder: (_, __, ___) {
                    return CustomTextField(
                      title: LocaleKeys.register_surname.locale,
                      validator: _vm.validateTextField,
                      icon: Icon(Icons.person_4_outlined),
                      controller: surname,
                      onChanged: (value) {
                        _vm.teacherSurname.value = value;
                      },
                    );
                  },
                ),
                emptyWidget(),
                LoginButton(
                  title: LocaleKeys.teacherAccount_updateButton.locale,
                  func: () {
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
      bool isOkey = await _vm.updateTeacherInfo(widget.teacherId!);
      if (isOkey) {
        navigateToNormalWidget(
            context,
            TeacherDrawerContent(
              userId: widget.teacherId!,
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
