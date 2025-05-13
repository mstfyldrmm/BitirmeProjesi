import 'package:qr_attendance_project/export.dart';

class ExelFile extends StatelessWidget with IconCreater {
  final VoidCallback onPressReadData;
  final VoidCallback onPressDeleteData;
  final String fileName;

  const ExelFile({
    super.key,
    required this.onPressReadData,
    required this.fileName,
    required this.onPressDeleteData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        EmptyWidget(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconCreator(iconPath: 'assets/icons/excel.png'),
            SizedBox(
              width: 10,
            ),
            Text(
              fileName,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: Theme.of(context).textTheme.labelMedium,
            )
          ],
        ),
        EmptyWidget(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CustomCardWidget(
                paddingValue: 20,
                childWidget: Column(
                  children: [
                    IconButton(
                      onPressed: () => onPressReadData.call(),
                      icon: iconCreaterNoColor(
                        'assets/icons/server.png',
                        context,
                      ),
                    ),
                    Text(
                      LocaleKeys.teacherAddLesson_checkExelFileData.locale,
                      style: Theme.of(context).textTheme.labelMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: CustomCardWidget(
                paddingValue: 20,
                childWidget: Column(
                  children: [
                    IconButton(
                      onPressed: () => onPressDeleteData.call(),
                      icon: iconCreaterNoColor(
                        'assets/icons/cancell.png',
                        context,
                      ),
                    ),
                    Text(
                      LocaleKeys.teacherAddLesson_deleteFileData.locale,
                      style: Theme.of(context).textTheme.labelMedium,
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
