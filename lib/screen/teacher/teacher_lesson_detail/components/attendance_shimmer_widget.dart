import 'package:flutter/material.dart';
import 'package:qr_attendance_project/screen/widgets/skelton_widget.dart';
import 'package:shimmer/shimmer.dart';

class AttendanceShimmerWidget extends StatelessWidget {
  const AttendanceShimmerWidget(
      {super.key, required this.height, required this.width});
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).hintColor.withAlpha(200),
      highlightColor: Theme.of(context).hintColor.withAlpha(60),
      child: SizedBox(
        height: height * 0.2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SkeltonWidget(width: width * 0.3, height: height / 15),
            Container(
                width: height / 4.5,
                height: height / 4.5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: SkeltonWidget(
                    width: width * 0.4,
                    height: height / 5,
                  ),
                )),
            SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
