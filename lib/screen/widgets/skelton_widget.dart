import 'package:flutter/material.dart';

class SkeltonWidget extends StatelessWidget {
  SkeltonWidget({
    super.key,
    this.childWidget,
    required this.width,
    required this.height,
  });
  final double width;
  final double height;
  Widget? childWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: childWidget ?? SizedBox.shrink(),
      width: width,
      height: height,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Theme.of(context).hintColor.withAlpha(20),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          )),
    );
  }
}
