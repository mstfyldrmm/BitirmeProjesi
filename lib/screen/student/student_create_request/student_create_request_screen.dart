import 'package:qr_attendance_project/export.dart';

class StudentCreateRequestScreen extends StatefulWidget {
  const StudentCreateRequestScreen({super.key, this.userId});
  final String? userId;

  @override
  State<StudentCreateRequestScreen> createState() =>
      _StudentRequestScreenState();
}

class _StudentRequestScreenState extends State<StudentCreateRequestScreen>
    with IconCreater {
  late final StudentCreateRequestView vm;
  final TextEditingController controller = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    vm = StudentCreateRequestView();
    vm.getAllTeacher();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarWidget(
          context,
          LocaleKeys.studentRequest_requestTitle.locale,
          iconCreaterColor('assets/icons/arrow-left.png', context)),
      body: Form(
        key: formKey,
        child: Padding(
          padding: WidgetSizes.normalPadding.value,
          child: SingleChildScrollView(
            child: Column(
              children: [
                iconCreaterColor('assets/icons/chat-service.png', context),
                EmptyWidget(
                  height: 20,
                ),
                DropdownWidget<String>(
                  itemToString: (value) => value,
                  aciklama: LocaleKeys.studentRequest_selectRequestType.locale,
                  onChanged: (value) => vm.requestType.value = value,
                  icerik: [
                    LocaleKeys.studentRequest_requestTypeOne.locale,
                    LocaleKeys.studentRequest_requestTypeTwo.locale,
                  ],
                ),
                EmptyWidget(
                  height: 20,
                ),
                ValueListenableBuilder(
                    valueListenable: vm.requestType,
                    builder: (_, __, ___) {
                      return vm.requestType.value ==
                              LocaleKeys.studentRequest_requestTypeTwo.locale
                          ? CustomTextField(
                              readOnly: true,
                              controller: dateController,
                              icon: IconButton(
                                onPressed: () async {
                                  dateController.text =
                                      await vm.selectDate(context);
                                  vm.selectedDate.value = dateController.text;
                                },
                                icon: Icon(
                                  Icons.calendar_today_outlined,
                                ),
                              ),
                              title: LocaleKeys
                                  .teacherLessonDetail_selectDate.locale,
                            )
                          : SizedBox.shrink();
                    }),
                EmptyWidget(),
                ValueListenableBuilder(
                  valueListenable: vm.teachers,
                  builder: (_, __, ___) {
                    return DropdownWidget<TeacherModel>(
                      aciklama: LocaleKeys.studentRequest_selectTeacher.locale,
                      onChanged: (selectedTeacher) {
                        vm.teacherName.value =
                            selectedTeacher?.teacherName ?? '';
                        vm.teacherId.value = selectedTeacher?.teacherId ?? '';
                        vm.getLessonsTeacher(selectedTeacher?.teacherId ?? '');
                      },
                      icerik: vm.teachers.value,
                      itemToString: (e) =>
                          '${e.teacherName ?? ''} ${e.teacherSurname ?? ''}',
                    );
                  },
                ),
                EmptyWidget(
                  height: 20,
                ),
                ValueListenableBuilder(
                  valueListenable: vm.teacherLessons,
                  builder: (_, __, ___) {
                    return vm.teacherLessons.value.isNotEmpty
                        ? PopupLessonSelector(
                            validator: vm.validateTextField,
                            selectedLesson: vm.requestLesson,
                            lessons: vm.teacherLessons.value
                                .map((e) => e['lessonName'] ?? '')
                                .toList(),
                            onSelected: (value) {
                              vm.requestLesson.value = value;

                              final selected =
                                  vm.teacherLessons.value.firstWhere(
                                (e) =>
                                    (e['lessonName'] ?? '')
                                        .toLowerCase()
                                        .trim() ==
                                    value.toLowerCase().trim(),
                                orElse: () => <String, String>{},
                              );

                              vm.requestLessonId.value =
                                  selected['lessonId']?.toString() ?? '';
                            },
                          )
                        : SizedBox.shrink();
                  },
                ),
                EmptyWidget(
                  height: 20,
                ),
                ValueListenableBuilder(
                  valueListenable: vm.requestDescription,
                  builder: (_, __, ___) {
                    return CustomTextField(
                      icon: SizedBox.shrink(),
                      title:
                          LocaleKeys.studentRequest_requestDescription.locale,
                      maxLines: 4,
                      controller: controller,
                      validator: vm.validateTextField,
                      onChanged: (value) {
                        vm.requestDescription.value = value;
                      },
                    );
                  },
                ),
                EmptyWidget(),
                CustomButton(
                  onPress: () {
                    if (formKey.currentState!.validate()) {
                      vm.createRequestPersons(
                          widget.userId ?? '', vm.teacherId.value);
                    }
                  },
                  title: LocaleKeys.studentRequest_createRequest.locale,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
