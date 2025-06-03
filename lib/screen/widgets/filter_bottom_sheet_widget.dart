import 'package:flutter/material.dart';
import 'package:qr_attendance_project/custom/ext/ext_string_localizations.dart';
import 'package:qr_attendance_project/custom/widget_sizes.dart';
import 'package:qr_attendance_project/generated/locale_keys.g.dart';
import 'package:qr_attendance_project/screen/widgets/custom_icon_creator.dart';

class FilterBottomSheetWidget extends StatelessWidget {
  const FilterBottomSheetWidget(
      {super.key,
      this.stateChange,
      required this.requestType,
      this.onPressed,
      required this.requestState});
  final void Function(String)? stateChange;
  final String requestType;
  final String requestState;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.6,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Padding(
          padding: WidgetSizes.normalPadding.value,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Talep Tipi',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              RadioMenuButton(
                  value: LocaleKeys.studentRequest_requestTypeOne.locale,
                  groupValue: requestType,
                  onChanged: (value) {
                    stateChange?.call(value.toString());
                  },
                  child: Text(
                    'Ders Kayıt Talepleri',
                    style: Theme.of(context).textTheme.titleSmall,
                  )),
              RadioMenuButton(
                  value: LocaleKeys.studentRequest_requestTypeTwo.locale,
                  groupValue: requestType,
                  onChanged: (value) {
                    stateChange?.call(value ?? "");
                  },
                  child: Text(
                    'Yoklama Talepleri',
                    style: Theme.of(context).textTheme.titleSmall,
                  )),
              Text(
                'Talep Durumu',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              RadioMenuButton(
                  value: "false",
                  groupValue: requestState,
                  onChanged: (value) {
                    stateChange?.call(value.toString());
                  },
                  child: Text(
                    'Bekliyor',
                    style: Theme.of(context).textTheme.titleSmall,
                  )),
              RadioMenuButton(
                  value: "true",
                  groupValue: requestState,
                  onChanged: (value) {
                    stateChange?.call(value.toString());
                  },
                  child: Text(
                    'Tamamlandı',
                    style: Theme.of(context).textTheme.titleSmall,
                  )),
              IconButton(
                  onPressed: () {
                    onPressed?.call();
                  },
                  icon: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconCreator(
                          iconPath: 'assets/icons/filter.png',
                          iconSize: 40,
                          iconColor: Theme.of(context).hintColor.withValues(
                                alpha: 1,
                              )),
                      SizedBox(width: 10),
                      Text(
                        'Filtrele',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
