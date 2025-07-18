import 'package:qr_attendance_project/export.dart';

class CustomEmptyDataWidget extends StatelessWidget {
  const CustomEmptyDataWidget(
      {super.key,
      required this.title,
      required this.imagePath,
      this.emptySize,
      this.iconSize});
  final String title;
  final String imagePath;
  final double? iconSize;
  final double? emptySize;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EmptyWidget(
            height: emptySize ?? 10,
          ),
          CustomIconCreator(
            iconPath: imagePath,
            iconSize: iconSize ?? screenHeight * 0.5,
            iconColor: Theme.of(context).hintColor.withValues(alpha: 1),
          ),
          EmptyWidget(
            height: 30,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
