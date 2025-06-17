import 'package:qr_attendance_project/export.dart';

class TeacherRequestCardWidget extends StatelessWidget with IconCreater {
  const TeacherRequestCardWidget({
    super.key,
    required this.requestModel,
    required this.solveProblemFunction,
  });
  final RequestModel requestModel;
  final VoidCallback solveProblemFunction;

  @override
  Widget build(BuildContext context) {
    final Color iconColor = Theme.of(context).hintColor.withValues(alpha: 1);
    return CustomCardWidget(
      paddingValue: 5,
      childWidget: Padding(
        padding: WidgetSizes.normalPadding.value,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  requestModel.requestType == 1
                      ? LocaleKeys.studentRequest_requestTypeOne.locale
                      : LocaleKeys.studentRequest_requestTypeTwo.locale,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                CustomIconCreator(
                  iconPath: requestModel.requestState!
                      ? 'assets/icons/approved.png'
                      : 'assets/icons/deadline.png',
                  iconSize: 50,
                ),
              ],
            ),
            EmptyWidget(
              height: 10,
            ),
            Text(requestModel.requestLesson ?? '',
                style: Theme.of(context).textTheme.titleSmall),
            EmptyWidget(),
            Text(requestModel.requestStudentId ?? '',
                style: Theme.of(context).textTheme.titleSmall),
            EmptyWidget(),
            Divider(),
            EmptyWidget(),
            Text(requestModel.requestDescription ?? '',
                style: Theme.of(context).textTheme.bodyMedium),
            EmptyWidget(),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIconCreator(
                      iconPath: 'assets/icons/calender.png',
                      iconColor: iconColor,
                      iconSize: 50,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      formatDateTime(requestModel.requestDate!.toDate()),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                requestModel.requestState!
                    ? SizedBox.shrink()
                    : IconButton(
                        onPressed: () => solveProblemFunction.call(),
                        icon: CustomIconCreator(
                            iconPath: 'assets/icons/maintenance.png',
                            iconColor: iconColor),
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String formatDateTime(DateTime dateTime) {
    return "${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')} -${dateTime.year}"
        " ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }
}
