import 'package:flutter/material.dart';

PreferredSizeWidget CustomAppBar(
  BuildContext context, {
  required String title,
}) {
  return AppBar(
    centerTitle: true,
    title: Text(
      title,
      style: Theme.of(context).textTheme.titleLarge,
      softWrap: true,
      maxLines: 2,
      textAlign: TextAlign.center,
    ),
    leading: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  );
}
