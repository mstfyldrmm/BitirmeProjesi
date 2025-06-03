import 'package:flutter/material.dart';
import 'package:qr_attendance_project/export.dart';

class ShimmerRequestWidget extends StatelessWidget {
  const ShimmerRequestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: Theme.of(context).hintColor.withAlpha(200),
          highlightColor: Theme.of(context).hintColor.withAlpha(60),
          child: SizedBox(
            height: height * 0.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SkeltonWidget(width: width * 0.7, height: height / 10),
                SkeltonWidget(width: width * 0.1, height: height / 15),
              ],
            ),
          ),
        ),
        SizedBox(
          height: height * 0.6,
          child: ListView.separated(
            separatorBuilder: (context, index) => EmptyWidget(),
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return Shimmer.fromColors(
                baseColor: Theme.of(context).hintColor.withAlpha(200),
                highlightColor: Theme.of(context).hintColor.withAlpha(60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SkeltonWidget(width: width / 2, height: height / 20),
                        CircleAvatar(
                          child: SkeltonWidget(
                              width: width / 4, height: height / 20),
                        ),
                      ],
                    ),
                    EmptyWidget(),
                    SkeltonWidget(width: width / 2, height: height / 20),
                    EmptyWidget(),
                    SkeltonWidget(width: width / 1.5, height: height / 20),
                    EmptyWidget(
                      height: 1,
                    ),
                    SkeltonWidget(width: width / 4, height: height / 20),
                    EmptyWidget(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SkeltonWidget(width: width / 8, height: height / 20),
                        SkeltonWidget(width: width / 4, height: height / 20),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
