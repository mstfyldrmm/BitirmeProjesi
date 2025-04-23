import 'package:qr_attendance_project/export.dart';

class DropdownWidget<T> extends StatelessWidget {
  final String aciklama;
  final List<T> icerik;
  final String Function(T) itemToString;
  final ValueChanged<T?>? onChanged;
  final T? selectedValue; // 👈 BURASI EKLENDİ

  const DropdownWidget({
    super.key,
    required this.aciklama,
    required this.icerik,
    required this.itemToString,
    this.onChanged,
    this.selectedValue, // 👈 BURASI EKLENDİ
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonFormField2<T>(
        decoration: InputDecoration(border: InputBorder.none),
        isExpanded: true,
        hint: Text(aciklama),
        value: selectedValue, // 👈 ARTIK BURADA DIŞARDAN ALINIYOR
        items: icerik.map((item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(itemToString(item)),
          );
        }).toList(),
        onChanged: onChanged,
        validator: (value) => value == null ? 'Lütfen seçim yapın' : null,
        dropdownStyleData: DropdownStyleData(
          padding: WidgetSizes.smallPadding.value,
          elevation: 10,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
