import 'package:qr_attendance_project/export.dart';

class RequestCardWidget extends StatelessWidget with IconCreater {
  const RequestCardWidget({super.key, required this.requestModel});
  final RequestModel requestModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
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
                Text(requestModel.requestDate!.toDate().toString(),
                    style: Theme.of(context).textTheme.titleMedium),
              ],
            )
          ],
        ),
      ),
    );
  }
}
