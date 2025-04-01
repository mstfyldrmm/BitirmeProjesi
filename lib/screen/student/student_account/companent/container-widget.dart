import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Image.asset(
        'assets/icons/tutorr.png',
        alignment: Alignment(0.0, 1.7),
      ),
      height: size.height / 3.1,
      width: size.width,
      decoration: ShapeDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
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
