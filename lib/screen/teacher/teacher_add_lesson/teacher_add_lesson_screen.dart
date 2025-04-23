import 'package:qr_attendance_project/export.dart';
import 'package:qr_attendance_project/screen/teacher/teacher_add_lesson/components/custom_lesson_container.dart';
import 'package:qr_attendance_project/screen/teacher/teacher_add_lesson/components/exel_file.dart';

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
    super.initState();
    _vm = TeacherAddLessonView();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: CustomAppBar(
        context,
        title: LocaleKeys.teacherAddLesson_title.locale,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: WidgetSizes.normalPadding.value,
            child: Column(
              children: [
                SizedBox(
                  width: 150,
                  child: iconCreaterColor(
                    'assets/icons/education.png',
                    context,
                  ),
                ),
                EmptyWidget(
                  height: 20,
                ),
                ValueListenableBuilder(
                  valueListenable: _vm.lessonName,
                  builder: (_, __, ___) {
                    return CustomLessonContainer(
                      value: _vm.lessonName.value,
                      title: LocaleKeys.teacherAddLesson_lessonName.locale,
                      icon: iconCreaterColor('assets/icons/book.png', context),
                    );
                  },
                ),
                EmptyWidget(
                  height: 15,
                ),
                ValueListenableBuilder(
                  valueListenable: _vm.lessonCode,
                  builder: (_, __, ___) {
                    return CustomLessonContainer(
                        title: LocaleKeys.teacherAddLesson_lessonCode.locale,
                        icon: iconCreaterColor(
                          'assets/icons/serialization.png',
                          context,
                        ),
                        value: _vm.lessonCode.value);
                  },
                ),
                EmptyWidget(
                  height: 15,
                ),
                ValueListenableBuilder(
                    valueListenable: _vm.lessonSection,
                    builder: (_, __, ___) {
                      return CustomLessonContainer(
                        title: LocaleKeys.teacherAddLesson_lessonSection.locale,
                        value: _vm.lessonSection.value,
                        icon: iconCreaterColor(
                          'assets/icons/school.png',
                          context,
                        ),
                      );
                    }),
                EmptyWidget(
                  height: 15,
                ),
                ValueListenableBuilder(
                  valueListenable: _vm.fileSelected,
                  builder: (_, __, ___) {
                    return _vm.fileSelected.value
                        ? ExelFile(
                            onPressReadData: () => _vm.readExcel(),
                            onPressDeleteData: () => _vm.deleteExcelData(),
                            fileName: _vm.getExcelFileName(),
                          )
                        : excelButton(
                            onPressButton: () => _vm.pickExcelFile(),
                          );
                  },
                ),
                CustomButton(
                    title: LocaleKeys.teacherAddLesson_addLessonButton.locale,
                    onPress: () async {
                      bool registerState = await _vm
                          .completeLessonRegistration(widget.teacherId);
                      registerState
                          ? navigateToWidget(
                              context,
                              TeacherDrawerContent(
                                userId: widget.teacherId,
                              ),
                            )
                          : showCustomSnackBar(
                              context,
                              'Ders kayıt işlemlerinde hata meydana geldi',
                              true);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget excelButton({required VoidCallback onPressButton}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () => onPressButton.call(),
            icon: iconCreaterColor('assets/icons/upload-file.png', context)),
        Text(
          LocaleKeys.teacherAddLesson_uploadExcelFile.locale,
          style: Theme.of(context).textTheme.titleMedium,
        )
      ],
    );
  }
}
