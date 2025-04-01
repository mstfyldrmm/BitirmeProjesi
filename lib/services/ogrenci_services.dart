import 'package:cloud_firestore/cloud_firestore.dart';

class OgrenciServices {
  final studentCollection = FirebaseFirestore.instance.collection('ogrenciler');
  //Model istenmesi gerekiyor

  Future<void> registerStudent({
    required String numara,
    required String name,
    required String surname,
    required String mail,
    required String password,
    List<String> dersler = const [],
  }) async {
    await studentCollection.doc(numara).set(
        {
          'numara': numara,
          'name': name,
          'surname': surname,
          'mail': mail,
          'password': password,
          'dersler': dersler, 
        },
        SetOptions(
            merge: true)); 
  }
}
