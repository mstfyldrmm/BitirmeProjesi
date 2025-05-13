import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Image.asset(
        'assets/icons/teacher.png',
        color: Theme.of(context).hintColor.withValues(
              alpha: 1,
            ),
        alignment: Alignment(0.0, 1.5),
      ),
      height: size.height / 4,
      width: size.width,
      decoration: ShapeDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.elliptical(270, 50),
            bottomRight: Radius.elliptical(270, 50),
          ),
        ),
      ),
    );
  }
}
