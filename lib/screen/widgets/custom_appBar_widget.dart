import 'package:flutter/material.dart';

PreferredSizeWidget customAppBarWidget(
  BuildContext context,
  String title,
  Widget leading,
) {
  return AppBar(
    centerTitle: true,
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: leading),
    title: Text(title),
  );
}
