import '../../../export.dart';

class QrGeneratorScreen extends StatefulWidget {
  final LessonModel lessonModel;
  const QrGeneratorScreen({super.key, required this.lessonModel});

  @override
  State<QrGeneratorScreen> createState() => _QrGeneratorScreenState();
}

class _QrGeneratorScreenState extends State<QrGeneratorScreen>
    with NavigatorManager, TickerProviderStateMixin {
  late final QrGeneratorView _vm;
  final TextEditingController dateLimitController = TextEditingController();
  final CountDownController _controller = CountDownController();
  late final TabController _tabController;

  @override
  void initState() {
    _vm = QrGeneratorView();
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    dateLimitController.dispose();
    _vm.stopTimer();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        context,
        title: LocaleKeys.teacherTitle_qrGenerator.locale,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: WidgetSizes.normalPadding.value,
            child: Column(
              children: [
                ValueListenableBuilder(
                  valueListenable: _vm.timerLimit,
                  builder: (_, __, ___) {
                    return Column(
                      children: [
                        ValueListenableBuilder(
                          valueListenable: _vm.isCreatedQr,
                          builder: (_, __, ___) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                children: _vm.isCreatedQr.value
                                    ? [
                                        /// Dynamic Qr Image
                                        ValueListenableBuilder(
                                          valueListenable: _vm.qrData,
                                          builder: (_, __, ___) {
                                            return _dynamicQrImage(
                                              screenHeight / 3,
                                            );
                                          },
                                        ),
                                      ]
                                    : [
                                        noAttendanceIcon(
                                          screenHeight / 3,
                                        ),
                                        ValueListenableBuilder(
                                          valueListenable: _vm.tabCurrentIndex,
                                          builder: (_, __, ___) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 5,
                                              ),
                                              child: Column(
                                                children: [
                                                  /// Tab Bar: Time Type Select
                                                  _tabBar(),
                                                  EmptyWidget(
                                                    height: 20,
                                                  ),

                                                  /// Text Field: Time Type Select
                                                  CustomTextField(
                                                    controller:
                                                        dateLimitController,
                                                    title:
                                                        ' ${_vm.timerLimitType()}',
                                                    icon: Icon(Icons.timer),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    textInputFormatter: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                    ],
                                                    onChanged: (String value) {
                                                      final intValue =
                                                          int.tryParse(value) ??
                                                              0;
                                                      _vm.timerLimit.value =
                                                          intValue;
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),

                                        /// Create Attendance QR
                                        startQrGeneratorButton(),
                                      ],
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dynamicQrImage(double size) {
    return Visibility(
      visible: _vm.isCreatedQr.value,
      child: Column(
        children: [
          QrImageView(
            size: size,
            backgroundColor: Colors.white,
            data: _vm.qrData.value,
          ),
          Text("Data: ${_vm.qrData.value}"),
          EmptyWidget(
            height: 20,
          ),
          ValueListenableBuilder(
            valueListenable: _vm.remainingTime,
            builder: (_, time, __) {
              return CircularTimerWidget(
                height: size / 1.5,
                controller: _controller,
                totalTime: _vm.remainingTime.value,
              );
            },
          ),
          EmptyWidget(
            height: 20,
          ),
          IconButton(
            onPressed: () {
              _vm.deleteAttendance(attendanceId: _vm.qrData.value);
            },
            icon: Column(
              children: [
                CustomIconCreator(
                  iconPath: 'assets/icons/stopQrGenerator.png',
                  iconColor: Theme.of(context).hintColor.withValues(alpha: 1),
                  iconSize: 100,
                ),
                Text(
                  LocaleKeys.teacherLessonDetail_endQrCode.locale,
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabBar() {
    return CustomCardWidget(
      paddingValue: 10,
      childWidget: TabBar(
        controller: _tabController,
        labelStyle: Theme.of(context).textTheme.titleMedium,
        dividerColor: Colors.transparent,
        unselectedLabelStyle: Theme.of(context).textTheme.labelSmall,
        indicatorColor: Theme.of(context).hintColor.withValues(alpha: 1),
        onTap: (index) => _vm.selectTabItem(index),
        tabs: [
          TabBarItem(tabBarTitle: LocaleKeys.teacherLessonDetail_second.locale),
          TabBarItem(tabBarTitle: LocaleKeys.teacherLessonDetail_minute.locale),
          TabBarItem(tabBarTitle: LocaleKeys.teacherLessonDetail_hour.locale),
        ],
      ),
    );
  }

  Widget noAttendanceIcon(double size) {
    return Center(
      child: CustomIconCreator(
        iconSize: size,
        iconPath: 'assets/gifs/sleepQr2.gif',
        iconColor: Theme.of(context).hintColor.withValues(
              alpha: 1,
            ),
      ),
    );
  }

  Widget startQrGeneratorButton() {
    return IconButton(
      onPressed: () async {
        bool isSuccess = await _vm.startAttendance(
          lessonModel: widget.lessonModel,
        );
        isSuccess
            ? showCustomSnackBar(
                context,
                LocaleKeys.teacherLessonDetail_attendanceSuccessMessage.locale,
                false)
            : showCustomSnackBar(
                context,
                LocaleKeys.teacherLessonDetail_attendanceErrorMessage.locale,
                true,
              );
      },
      icon: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomIconCreator(
            iconPath: 'assets/icons/startAttendanceTwo.png',
            iconColor: Theme.of(context).hintColor.withValues(alpha: 1),
            iconSize: 140,
          ),
          Text(
            LocaleKeys.teacherLessonDetail_createAttendance.locale,
            style: Theme.of(context).textTheme.titleMedium,
          )
        ],
      ),
    );
  }
}
