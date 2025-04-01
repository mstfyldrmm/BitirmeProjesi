import 'package:flutter/material.dart';

mixin IconCreater {
  Widget iconCreaterNoColor(String path, BuildContext context) {
    return Image.asset(
      path,
    );
  }

  Widget iconCreaterColor(String path, BuildContext context) {
    return Image.asset(
      path,
      color: Theme.of(context).hintColor.withValues(alpha: 1),
    );
  }
}
