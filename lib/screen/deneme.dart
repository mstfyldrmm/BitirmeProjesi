import 'package:flutter/material.dart';

class ThemeSegmentedButton extends StatefulWidget {
  final Function(bool) onThemeChanged;
  ThemeSegmentedButton({required this.onThemeChanged});

  @override
  _ThemeSegmentedButtonState createState() => _ThemeSegmentedButtonState();
}

class _ThemeSegmentedButtonState extends State<ThemeSegmentedButton> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<bool>(
      segments: const [
        ButtonSegment(value: false, label: Text("🌞 Light")),
        ButtonSegment(value: true, label: Text("🌙 Dark")),
      ],
      selected: {isDarkMode},
      onSelectionChanged: (newSelection) {
        setState(() => isDarkMode = newSelection.first);
        widget.onThemeChanged(isDarkMode);
      },
    );
  }
}
