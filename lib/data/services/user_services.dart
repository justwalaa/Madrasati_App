import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final _firestore = FirebaseFirestore.instance;

  Future<String> getUserClassId(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    return doc['classId'];
  }
}
