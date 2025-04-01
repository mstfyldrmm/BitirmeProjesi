import 'package:flutter/material.dart';
import 'package:qr_attendance_project/provider/theme_provider.dart';

PreferredSizeWidget CustomAppBar(ThemeProvider provider, String title) {
  return AppBar(
    centerTitle: true,
    title: Text(title),
    actions: [
      IconButton(
        icon: Icon(
          provider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
        ),
        onPressed: () {
          provider.toggleTheme();
        },
      ),
    ],
  );
}
