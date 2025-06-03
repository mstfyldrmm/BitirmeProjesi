import 'package:qr_attendance_project/export.dart';

class RequestCardWidget extends StatelessWidget with IconCreater {
  const RequestCardWidget({super.key, required this.requestModel});
  final RequestModel requestModel;
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
                  requestModel.requestType == 1
                      ? LocaleKeys.studentRequest_requestTypeOne.locale
                      : LocaleKeys.studentRequest_requestTypeTwo.locale,
                  style: Theme.of(context).textTheme.titleMedium,
                  softWrap: true,
                  maxLines: 2,
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
              height: 20,
            ),
            Text(requestModel.requestLesson ?? '',
                style: Theme.of(context).textTheme.titleMedium),
            EmptyWidget(
              height: 20,
            ),
            Text(requestModel.requestDescription ?? '',
                style: Theme.of(context).textTheme.bodyMedium),
            EmptyWidget(),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                iconCreaterColor('assets/icons/date.png', context),
                Text(formatDateTime(requestModel.requestDate!.toDate()),
                    style: Theme.of(context).textTheme.titleMedium),
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
