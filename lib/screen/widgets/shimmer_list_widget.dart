import 'package:flutter/material.dart';
import 'package:qr_attendance_project/export.dart';
import 'package:qr_attendance_project/screen/widgets/skelton_widget.dart';

class ShimmerListWidget extends StatelessWidget {
  const ShimmerListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          baseColor: Theme.of(context).hintColor.withAlpha(200),
          highlightColor: Theme.of(context).hintColor.withAlpha(60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  SkeltonWidget(
                    width: width / 4,
                    height: 100,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    children: [
                      SkeltonWidget(
                        width: width / 2.5,
                        height: 50,
                      ),
                      EmptyWidget(),
                      SkeltonWidget(
                        width: width / 2.5,
                        height: 30,
                      )
                    ],
                  ),
                  SizedBox(width: 10),
                  SkeltonWidget(
                    width: width / 5.5,
                    height: 50,
                  )
                ],
              ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return EmptyWidget();
      },
      itemCount: 6,
    );
  }
}
