import 'package:flutter/material.dart';

AppBar customAppBar(BuildContext context, String title) {
  return AppBar(
    centerTitle: true,
    title: Text(title),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: IconButton(
          icon: Image.asset('assets/icons/ring.png',
              color: Theme.of(context).hintColor),
          onPressed: () {},
        ),
      ),
    ],
    leading: Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.only(left: 10),
        child: IconButton(
          icon: Image.asset('assets/icons/menu.png',
              color: Theme.of(context).hintColor),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      );
    }),
  );
}
