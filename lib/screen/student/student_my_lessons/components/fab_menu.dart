import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_attendance_project/custom/icon_creater.dart';
import 'package:qr_attendance_project/custom/navigate_to_widget.dart';


class FabMenu extends StatefulWidget {
  FabMenu({super.key, required this.isExpanded});
  bool isExpanded;

  @override
  State<FabMenu> createState() => _FabMenuState();
}

class _FabMenuState extends State<FabMenu> with NavigatorManager, IconCreater {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.bounceIn,
      duration: const Duration(milliseconds: 300),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          // Menü seçenekleri
          if (widget.isExpanded) ...[
            Positioned(
              right: 20,
              bottom: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildOptionButton(Icons.add, "Ders Kayıt Talebi Oluştur",
                      Theme.of(context).primaryColor, () {
                    navigateToWidget(context, SizedBox());
                  }),
                  SizedBox(height: 10),
                  _buildOptionButton(Icons.message, "Danışmana Mesaj",
                      Theme.of(context).primaryColor, () {}),
                  SizedBox(height: 10),
                  _buildOptionButton(Icons.help, "Sıkça Sorulan Sorular",
                      Theme.of(context).primaryColor, () {}),
                ],
              ),
            ),
          ],

          // Ana FAB Butonu
          Positioned(
            right: 10,
            bottom: 10,
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              isExtended: true,
              elevation: 0,
              onPressed: () {
                setState(() {
                  widget.isExpanded = !widget.isExpanded; // Menü açma/kapama
                });
              },
              child: widget.isExpanded
                  ? iconCreaterNoColor('assets/icons/cancel.png', context)
                  : Center(
                      child: LottieBuilder.asset(
                        'assets/lottie/WmdyPOoW2f.json',
                        fit: BoxFit.fill,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionButton(
      IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 5, spreadRadius: 2),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
            ),
            SizedBox(width: 8),
            Text(label, style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
