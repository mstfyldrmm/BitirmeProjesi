import 'package:flutter/material.dart';
import 'package:qr_attendance_project/screen/widgets/skelton_widget.dart';
import 'package:shimmer/shimmer.dart';

class AttendanceShimmerWidget extends StatelessWidget {
  const AttendanceShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Shimmer.fromColors(
        baseColor: Theme.of(context).hintColor.withAlpha(200),
        highlightColor: Theme.of(context).hintColor.withAlpha(60),
        child: ListView.builder(itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              SkeltonWidget(width: width / 12, height: height / 24),
              SkeltonWidget(width: width / 12, height: height / 24),
              SkeltonWidget(width: width / 12, height: height / 24)
            ],
          );
        }));
  }
}
