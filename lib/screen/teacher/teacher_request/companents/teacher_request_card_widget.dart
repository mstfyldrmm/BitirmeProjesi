import 'package:qr_attendance_project/export.dart';
import 'package:qr_attendance_project/screen/widgets/custom_card_widget.dart';

class TeacherRequestCardWidget extends StatelessWidget with IconCreater {
  const TeacherRequestCardWidget({
    super.key,
    required this.requestModel,
    required this.studentInfo,
    required this.solveProblemFunction,
  });
  final RequestModel requestModel;
  final String studentInfo;
  final VoidCallback solveProblemFunction;
  @override
  Widget build(BuildContext context) {
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
                  requestModel.requestType ?? '',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Container(
                  padding: WidgetSizes.smallPadding.value,
                  decoration: BoxDecoration(
                    color:
                        requestModel.requestState! ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    requestModel.requestState!
                        ? LocaleKeys.studentRequest_stateTwo.locale
                        : LocaleKeys.studentRequest_stateOne.locale,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                )
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
                  children: [
                    iconCreaterColor('assets/icons/calender.png', context),
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
                          iconColor:
                              Theme.of(context).hintColor.withValues(alpha: 1),
                        ),
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
