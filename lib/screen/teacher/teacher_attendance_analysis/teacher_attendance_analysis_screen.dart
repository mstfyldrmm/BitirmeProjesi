import 'package:flutter/material.dart';
import 'package:qr_attendance_project/custom/app_bar.dart';
import 'package:qr_attendance_project/custom/widget_sizes.dart';
import 'package:qr_attendance_project/screen/teacher/teacher_attendance_analysis/teacher_attendance_analysis_view.dart';
import 'package:qr_attendance_project/screen/widgets/custom_card_widget.dart';
import 'package:qr_attendance_project/screen/widgets/custom_icon_creator.dart';

class TeacherAttendanceAnalysisScreen extends StatefulWidget {
  const TeacherAttendanceAnalysisScreen(
      {super.key, required this.lessonId, required this.lessonName});
  final String lessonId; // Replace with actual lesson ID
  final String lessonName;
  @override
  State<TeacherAttendanceAnalysisScreen> createState() =>
      _TeacherAttendanceAnalysisScreenState();
}

class _TeacherAttendanceAnalysisScreenState
    extends State<TeacherAttendanceAnalysisScreen> {
  late final TeacherAttendanceAnalysisView _view;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _view = TeacherAttendanceAnalysisView();
    _view.createPdfFile(widget.lessonName);
    _view.fetchLessonAllAttendances(lessonId: widget.lessonId);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: CustomAppBar(
          context,
          title: 'Yoklama Raporu',
        ),
        body: Padding(
          padding: WidgetSizes.normalPadding.value,
          child: Column(
            children: [
              Center(
                child: CustomIconCreator(
                  iconPath: 'assets/icons/yoklama_rapor.png',
                  iconSize: height * 0.5,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width * 0.44,
                    child: CustomCardWidget(
                        paddingValue: 10,
                        childWidget: Column(
                          children: [
                            ValueListenableBuilder(
                                valueListenable: _view.attendanceList,
                                builder: (_, __, ___) {
                                  return IconButton(
                                    onPressed: () async {
                                      final createdPdf = await _view
                                          .createPdfFile(widget.lessonName);
                                      await _view.sharePDF(
                                          widget.lessonName, createdPdf);
                                    },
                                    icon: CustomIconCreator(
                                      iconPath: 'assets/icons/share.png',
                                      iconColor:
                                          Theme.of(context).primaryColorLight,
                                    ),
                                  );
                                }),
                            Text(
                              'Tüm Yoklamaları Dışa Aktar',
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  SizedBox(
                    width: width * 0.44,
                    child: CustomCardWidget(
                        paddingValue: 10,
                        childWidget: Column(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: CustomIconCreator(
                                iconPath: 'assets/icons/evaluation.png',
                                iconColor: Theme.of(context).primaryColorLight,
                              ),
                            ),
                            Text(
                              'Tüm Yoklamaları Dışa Aktar',
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          ],
                        )),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
