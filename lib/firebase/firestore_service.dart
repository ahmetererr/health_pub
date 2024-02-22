import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser(String uid, String name, String email) async {
    await _firestore.collection('users').doc(uid).set({
      'name': name,
      'email': email,
    });
  }

  Future<Map<String, dynamic>> getUserData(String uid) async {
    DocumentSnapshot documentSnapshot =
    await _firestore.collection('users').doc(uid).get();

    return documentSnapshot.data() as Map<String, dynamic>;
  }
}
