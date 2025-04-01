import 'package:flutter/material.dart';
import 'package:qr_attendance_project/custom/circularPercentWidget.dart';

Widget katilimDurumu(String date) {
    return PageView.builder(itemBuilder: (BuildContext context, int index) {
      return Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              date,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            circularPercentWidget(
              context,
              0.5,
              "%50\nKatılım",
            ),
            IconButton(
                onPressed: () {},
                icon: Image.asset(
                  'assets/icons/file.png',
                  color: Theme.of(context).hintColor,
                ))
          ],
        ),
      );
    });
  }