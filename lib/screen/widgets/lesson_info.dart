import 'package:flutter/material.dart';
import 'package:qr_attendance_project/export.dart';

class LessonInfo extends StatelessWidget {
  final LessonModel lessonModel;

  const LessonInfo({super.key, required this.lessonModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/images.jpg'), fit: BoxFit.fill),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColorDark,
            Theme.of(context).primaryColor
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(lessonModel.lessonName ?? '',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(
                  'Ders Kodu: ${lessonModel.lessonCode ?? ''}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                EmptyWidget(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(Icons.person_2_outlined, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      lessonModel.teacherName ?? '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
                EmptyWidget(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(Icons.school_outlined, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      lessonModel.section ?? '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
                EmptyWidget(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.class_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8),
                    Text(
                      '2.sınıf',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
                EmptyWidget(
                  height: 5,
                )
              ],
            ),
          ),
          Positioned(
            top: 35,
            right: 10,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text("${lessonModel.students!.length}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.white)),
                  Text(
                    "Öğrenci",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                  CustomIconCreator(
                    iconPath: 'assets/icons/students.png',
                    iconColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
