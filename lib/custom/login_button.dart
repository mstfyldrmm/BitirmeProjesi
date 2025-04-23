import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  const CustomButton({
    super.key,
    required this.onPress,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 1,
        child: ElevatedButton(
          onPressed: () => onPress.call(),
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(ColorScheme.light().error),
            padding: WidgetStateProperty.all<EdgeInsets>(
              EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            ),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
