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
    this.validator, this.keyboardType,
  });
  final String title;
  final Widget icon;
  final BorderRadius radius;
  final TextEditingController controller;
  final bool sifreGizle;
  final Function? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      obscureText: sifreGizle,
      validator: validator,
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
        errorBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(
            color: ColorScheme.light().error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
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
