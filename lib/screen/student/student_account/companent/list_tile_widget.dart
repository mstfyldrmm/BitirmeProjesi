import 'package:qr_attendance_project/export.dart';


class ListTileWidget extends StatelessWidget with IconCreater {
  ListTileWidget(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.trailingWidget,
      this.textColor});
  final String imagePath;
  final String title;
  final Widget trailingWidget;
  Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      title: Text(
        title,
        style:
            Theme.of(context).textTheme.titleMedium?.copyWith(color: textColor),
      ),
      trailing: trailingWidget,
      leading: iconCreaterColor(imagePath, context),
    );
  }
}
