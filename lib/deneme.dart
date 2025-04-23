import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:qr_attendance_project/custom/icon_creater.dart';

class Deneme extends StatelessWidget with IconCreater {
  const Deneme({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: ListTile(
              leading: Icon(Icons.school, color: Colors.deepPurple),
              title: Text("YZ302 - Yapay Zeka"),
              subtitle: Text("Bilgisayar Mühendisliği"),
            ),
          ),
          GlassContainer(
            height: 120,
            width: double.infinity,
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.2),
                Colors.white.withOpacity(0.05)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            blur: 10,
            borderWidth: 1.5,
            borderColor: Colors.black.withOpacity(0.2),
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Dersin Adı: Yapay Zeka",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  SizedBox(height: 4),
                  Text("Kodu: YZ302", style: TextStyle(color: Colors.white70)),
                  Text("Bölüm: Bilgisayar Müh.",
                      style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
