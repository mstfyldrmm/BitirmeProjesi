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
    return Scaffold(
      body: Padding(
        padding: WidgetSizes.normalPadding.value,
        child: widget.isSuccess
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomIconCreator(
                    iconPath: 'assets/gifs/successAttendancee.gif',
                    iconSize: 300,
                    iconColor: Theme.of(context).hintColor.withValues(
                          alpha: 1,
                        ),
                  ),
                  EmptyWidget(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomIconCreator(
                        iconSize: 40,
                        iconPath: 'assets/icons/accept.png',
                      ),
                      Text(
                          LocaleKeys
                              .studentLessonDetail_joinAttendanceSuccess.locale,
                          style: Theme.of(context).textTheme.titleLarge),
                    ],
                  ),
                  EmptyWidget(),
                  CustomCardWidget(
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
                              iconPath: 'assets/icons/qr-code-new.png',
                              iconColor: Theme.of(context).hintColor.withValues(
                                    alpha: 1,
                                  ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.qrCodeData?.substring(0, 23)}',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text(
                                  widget.lessonModel.lessonName ?? ' ',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text(
                                  "${widget.studentModel.studentName ?? ' '} ${widget.studentModel.studentSurname ?? ' '}",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => {
                          Navigator.of(context).pop(),
                          Navigator.of(context).pop(),
                        },
                        icon: CustomIconCreator(
                          iconSize: 100,
                          iconPath: 'assets/icons/arrow-left-two.png',
                          iconColor:
                              Theme.of(context).hintColor.withValues(alpha: 1),
                        ),
                      ),
                      Text(
                        LocaleKeys.studentLessonDetail_backToLessons.locale,
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    ],
                  ),
                ],
              )
            : Column(),
      ),
    );
  }
}
