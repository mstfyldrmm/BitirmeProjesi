import 'package:qr_attendance_project/custom/custom_loading.dart';
import 'package:qr_attendance_project/export.dart';
import 'package:qr_attendance_project/screen/teacher/teacher_add_lesson/companents/exel_button.dart';
import 'package:qr_attendance_project/screen/teacher/teacher_add_lesson/companents/exel_file.dart';
import 'package:qr_attendance_project/screen/teacher/teacher_add_lesson/teacher_add_lesson_view.dart';
import 'package:qr_attendance_project/screen/widgets/empty_widget.dart';

class TeacherAddLessonScreen extends StatefulWidget with IconCreater {
  const TeacherAddLessonScreen({super.key, required this.teacherId});
  final String teacherId;

  @override
  State<TeacherAddLessonScreen> createState() => _TeacherAddLessonScreenState();
}

class _TeacherAddLessonScreenState extends State<TeacherAddLessonScreen>
    with IconCreater, NavigatorManager {
  late final TeacherAddLessonView _vm;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _vm = TeacherAddLessonView();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController dersAd = TextEditingController();
    TextEditingController dersKod = TextEditingController();
    TextEditingController dersBolum = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: CustomAppBar(context, title: 'Ders Oluşturma'),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: WidgetSizes.normalPadding.value,
            child: Column(
              children: [
                EmptyWidget(
                  height: 20,
                ),
                Container(
                  width: 200,
                  child:
                      iconCreaterColor('assets/icons/education.png', context),
                ),
                EmptyWidget(
                  height: 20,
                ),
                ValueListenableBuilder(
                    valueListenable: _vm.lessonName,
                    builder: (_, __, ___) {
                      return CustomTextField(
                          validator: (value) => _vm.validateTextField(value),
                          title: 'Dersin Adı',
                          onChanged: (value) {
                            _vm.lessonName.value = value;
                          },
                          icon: iconCreaterColor(
                              'assets/icons/signature.png', context),
                          controller: dersAd);
                    }),
                EmptyWidget(
                  height: 15,
                ),
                ValueListenableBuilder(
                    valueListenable: _vm.lessonCode,
                    builder: (_, __, ___) {
                      return CustomTextField(
                          title: 'Dersin Kodu',
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            _vm.lessonCode.value = value;
                          },
                          validator: (value) => _vm.validateTextField(value),
                          icon: iconCreaterColor(
                              'assets/icons/license-plate.png', context),
                          controller: dersKod);
                    }),
                EmptyWidget(
                  height: 15,
                ),
                ValueListenableBuilder(
                    valueListenable: _vm.lessonSection,
                    builder: (_, __, ___) {
                      return CustomTextField(
                          title: 'Dersin Bölümü',
                          onChanged: (value) {
                            _vm.lessonSection.value = value;
                          },
                          validator: (value) => _vm.validateTextField(value),
                          icon: iconCreaterColor(
                              'assets/icons/department.png', context),
                          controller: dersBolum);
                    }),
                EmptyWidget(
                  height: 15,
                ),
                ValueListenableBuilder(
                    valueListenable: _vm.fileSelected,
                    builder: (_, __, ___) {
                      return _vm.fileSelected.value
                          ? ExelFile(
                              vm: _vm,
                            )
                          : ExelButton(
                              vm: _vm,
                            );
                    }),
                LoginButton(
                  title: 'Ders Kaydını Tamamla',
                  func: () async {
                    if (formKey.currentState!.validate()) {
                      bool lessonRegisterState = await _vm.saveLessonFirebase(
                          teacherName:
                              await _vm.fetchTeacherName(widget.teacherId));
                      if (lessonRegisterState) {
                        bool teacherLessonMethod = await _vm.saveTeacherLessons(
                            widget.teacherId, _vm.lessonId.value!);
                        bool studentLessonMethod =
                            await _vm.saveStudentsLessons(
                                _vm.students.value, _vm.lessonId.value!);
                        if (teacherLessonMethod && studentLessonMethod) {
                          showCustomSnackBar(
                              context,
                              "Ders kayıt işleminin tüm adımları başarılı",
                              false);
                          navigateToNormalWidget(context,
                              TeacherMyLessons(teacherId: widget.teacherId));
                        }
                      }
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
