import 'package:flutter/material.dart';

class CustomCardWidget extends StatelessWidget {
  const CustomCardWidget(
      {super.key, required this.paddingValue, required this.childWidget});
  final double paddingValue;
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            strokeAlign: 2,
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Theme.of(context).colorScheme.surfaceContainerLowest,
          boxShadow: [
            BoxShadow(
              color:
                  Theme.of(context).colorScheme.surfaceContainer.withAlpha(2),
              blurRadius: 12,
              spreadRadius: 4,
              offset: Offset(2, 4),
            )
          ]),
      padding: EdgeInsets.all(paddingValue),
      child: childWidget,
    );
  }
}
