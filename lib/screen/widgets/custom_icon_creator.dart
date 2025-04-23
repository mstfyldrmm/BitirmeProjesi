import 'package:qr_attendance_project/export.dart';

class CustomIconCreator extends StatelessWidget {
  final String iconPath;
  final Color? iconColor;
  final double? iconSize;
  const CustomIconCreator({
    super.key,
    required this.iconPath,
    this.iconColor, this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      iconPath,
      color: iconColor,
    );
  }
}
