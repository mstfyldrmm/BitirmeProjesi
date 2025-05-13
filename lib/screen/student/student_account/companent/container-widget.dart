import 'package:qr_attendance_project/export.dart';

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Image.asset(
        'assets/icons/reading.png',
        color: Theme.of(context).hintColor.withValues(
              alpha: 1,
            ),
        alignment: Alignment(0.0, 1.5),
      ),
      height: size.height / 4,
      width: size.width,
      decoration: ShapeDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.elliptical(270, 60),
            bottomRight: Radius.elliptical(270, 60),
          ),
        ),
      ),
    );
  }
}
