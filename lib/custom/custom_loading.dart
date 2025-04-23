import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void showCustomLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shadowColor: Colors.transparent,
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            color: Colors.transparent,
            child: Center(
              child: LoadingAnimationWidget.twoRotatingArc(
                color: Theme.of(context).hintColor..withAlpha(1),
                size: 60,
              ),
            ),
          ),
        ),
      );
    },
  );
}
