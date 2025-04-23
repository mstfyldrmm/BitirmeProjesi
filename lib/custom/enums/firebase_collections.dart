import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollections {
  students,
  lessons,
  requests,
  teachers;

  CollectionReference get reference =>
      FirebaseFirestore.instance.collection(name);
}
