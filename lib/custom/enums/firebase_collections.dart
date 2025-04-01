import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollections {
  students,
  lessons;

  CollectionReference get reference =>
      FirebaseFirestore.instance.collection(name);
}
