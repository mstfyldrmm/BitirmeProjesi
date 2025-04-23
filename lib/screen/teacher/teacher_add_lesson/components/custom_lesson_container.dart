import 'package:qr_attendance_project/export.dart';
import 'package:qr_attendance_project/screen/widgets/custom_card_widget.dart';
// glass_kit paketini import et

class CustomLessonContainer extends StatelessWidget {
  const CustomLessonContainer({
    super.key,
    required this.title,
    required this.icon,
    required this.value,
  });

  final String title;
  final Widget icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return CustomCardWidget(
      paddingValue: 20,
      childWidget: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.labelLarge,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
