import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollections {
  students,
  lessons,
  requests,
  teachers,
  firstGradeAttendance,
  secondGradeAttendance,
  thirdGradeAttendance,
  fourthGradeAttendance,
  attendances;

  CollectionReference get reference =>
      FirebaseFirestore.instance.collection(name);
}
