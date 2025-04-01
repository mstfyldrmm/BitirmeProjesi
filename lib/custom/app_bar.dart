import 'package:flutter/material.dart';

PreferredSizeWidget CustomAppBar(
  BuildContext context, {
  required String title,
}) {
  return AppBar(
    centerTitle: true,
    title: Text(title),
    leading: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  );
}
