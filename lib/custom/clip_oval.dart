import 'package:flutter/material.dart';

class OmuLogo extends StatelessWidget {
  OmuLogo({super.key, this.height});
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ClipOval(
            child: Image.asset(
      'assets/images/logo-3.png',
      height: height,
    )));
  }
}
