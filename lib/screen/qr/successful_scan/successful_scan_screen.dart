import 'package:qr_attendance_project/screen/qr/qr_scanner/components/un_successfull_scan_screen.dart';
import 'package:qr_attendance_project/screen/qr/successful_scan/successful_scan_view.dart';

import '../../../export.dart';

class SuccessfulScanScreen extends StatefulWidget {
  final bool isSuccess;
  final LessonModel lessonModel;
  final StudentModel studentModel;
  final String? qrCodeData;
  const SuccessfulScanScreen({
    super.key,
    required this.isSuccess,
    required this.lessonModel,
    required this.studentModel,
    this.qrCodeData,
  });

  @override
  State<SuccessfulScanScreen> createState() => _SuccessfulScanScreenState();
}

class _SuccessfulScanScreenState extends State<SuccessfulScanScreen>
    with NavigatorManager {
  late final SuccessfulScanView _vm;

  @override
  void initState() {
    _vm = SuccessfulScanView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
          padding: WidgetSizes.normalPadding.value,
          child: widget.isSuccess
              ? PopScope(
                  canPop: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomIconCreator(
                        iconPath: 'assets/gifs/successAttendancee.gif',
                        iconSize: height * 0.4,
                        iconColor: Theme.of(context).hintColor.withValues(
                              alpha: 1,
                            ),
                      ),
                      EmptyWidget(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomIconCreator(
                            iconSize: width * 0.1,
                            iconPath: 'assets/icons/accept.png',
                          ),
                          Text(
                              LocaleKeys
                                  .studentLessonDetail_joinAttendanceSuccess
                                  .locale,
                              style: Theme.of(context).textTheme.titleLarge),
                        ],
                      ),
                      EmptyWidget(),
                      SizedBox(
                        width:  width,
                        child: CustomCardWidget(
                          paddingValue: 20,
                          childWidget: Column(
                            children: [
                              Text(
                                LocaleKeys
                                    .studentLessonDetail_attendanceDetail.locale,
                                style: Theme.of(context).textTheme.titleLarge,
                                textAlign: TextAlign.center,
                              ),
                              EmptyWidget(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomIconCreator(
                                    iconSize: width * 0.15,
                                    iconPath: 'assets/icons/qr-code-new.png',
                                    iconColor:
                                        Theme.of(context).hintColor.withValues(
                                              alpha: 1,
                                            ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: width * 0.5,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            '${widget.qrCodeData?.substring(0, 23)}',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium),
                                        Text(
                                          widget.lessonModel.lessonName ?? ' ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        Text(
                                          "${widget.studentModel.studentName ?? ' '} ${widget.studentModel.studentSurname ?? ' '}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () => {
                              navigateToNormalWidget(
                                  context,
                                  StudentDrawerContent(
                                    userId: widget.studentModel.studentId,
                                  ))
                            },
                            icon: CustomIconCreator(
                              iconSize: width * 0.2,
                              iconPath: 'assets/icons/arrow-left-two.png',
                              iconColor: Theme.of(context)
                                  .hintColor
                                  .withValues(alpha: 1),
                            ),
                          ),
                          Text(
                            LocaleKeys.studentLessonDetail_backToLessons.locale,
                            style: Theme.of(context).textTheme.titleMedium,
                          )
                        ],
                      ),
                    ],
                  ))
              : UnSuccessfullScanScreen(
                  errorMessage: LocaleKeys
                      .studentLessonDetail_unsuccessfulAttendanceTwo.locale,
                  lessonModel: widget.lessonModel,
                  studentModel: widget.studentModel,
                  lessonName: widget.lessonModel.lessonName ?? ' ',
                )),
    );
  }
}
