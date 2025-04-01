import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.title,
    required this.icon,
    this.sifreGizle = false,
    this.radius = const BorderRadius.all(Radius.circular(10)),
    required this.controller,
    this.onChanged,
  });
  final String title;
  final Widget icon;
  final BorderRadius radius;
  final TextEditingController controller;
  final bool sifreGizle;
  final Function? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: sifreGizle,
      onChanged: _onChanged,
      decoration: InputDecoration(
        filled: true,
        prefixIcon: icon,
        labelText: title,
        labelStyle: Theme.of(context).textTheme.titleSmall,
        disabledBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(),
        ),
      ),
    );
  }

  void _onChanged(String value) {
    if (onChanged != null) {
      onChanged?.call(value.trim());
    }
  }
}
