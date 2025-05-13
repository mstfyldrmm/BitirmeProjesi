import '../../export.dart';

class CustomQrBottomSheetContent extends StatelessWidget {
  final String responseMessage;
  final VoidCallback onPressScan;
  final VoidCallback onPressBack;
  const CustomQrBottomSheetContent({
    super.key,
    required this.responseMessage,
    required this.onPressScan,
    required this.onPressBack,
  });

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: maxHeight,
      child: CustomCardWidget(
        paddingValue: 20,
        childWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomCardWidget(
                paddingValue: 20,
                childWidget: Column(
                  children: [
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Ders Kodu: ${responseMessage.split("-").first}",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              "Tarih: ${responseMessage.split("-").last}",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                )),
            EmptyWidget(
              height: 20,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () => onPressScan.call(),
                  icon: CustomIconCreator(
                    iconSize: 100,
                    iconPath: 'assets/icons/scan-again.png',
                    iconColor: Theme.of(context).hintColor.withValues(alpha: 1),
                  ),
                ),
                Text(
                  LocaleKeys.studentLessonDetail_scanAgain.locale,
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () => onPressBack.call(),
                  icon: CustomIconCreator(
                    iconSize: 100,
                    iconPath: 'assets/icons/arrow-left-two.png',
                    iconColor: Theme.of(context).hintColor.withValues(alpha: 1),
                  ),
                ),
                Text(
                  LocaleKeys.studentLessonDetail_backToLessons.locale,
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
