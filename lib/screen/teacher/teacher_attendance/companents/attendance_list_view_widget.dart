import 'package:flutter/material.dart';
import 'package:qr_attendance_project/model/attendance_model.dart';
import 'package:qr_attendance_project/screen/widgets/empty_widget.dart';

class AttendanceListViewWidget extends StatelessWidget {
  const AttendanceListViewWidget(
      {super.key, required this.height, required this.attendancesData});
  final double height;
  final List<AttendanceModel?> attendancesData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Card(
        child: ListView.separated(
          padding: EdgeInsets.symmetric(
            vertical: 20,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Theme.of(context).hintColor.withValues(alpha: 1),
                  ),
                ),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      attendancesData[index]!.studentId ?? '',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      attendancesData[index]!.studentName ?? '',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      attendancesData[index]!.studentSurname ?? '',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ]),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return EmptyWidget();
          },
          itemCount: attendancesData.length,
        ),
      ),
    );
  }
}
