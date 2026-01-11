import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  String? get currentUserId => _auth.currentUser?.uid;
  
  Future<void> logout() async {
  await _auth.signOut();
}


  Future<String?> login({
    required String email,
    required String password,
  }) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = cred.user!.uid;

    final doc = await _firestore.collection('users').doc(uid).get();
    return doc.data()?['role'];  
  }
  Future<String?> loginStudentWithNationalId({
  required String nationalId,
  required String password,
}) async {
 
  final q = await _firestore
      .collection('users')
      .where('nationalId', isEqualTo: nationalId)
      .where('role', isEqualTo: 'student')
      .limit(1)
      .get();

  if (q.docs.isEmpty) return null;

  final email = q.docs.first['email'];

 
  await _auth.signInWithEmailAndPassword(
    email: email,
    password: password,
  );

  return 'student';
}



  Future<User?> loginTeacher({
    required String email,
    required String password,
  }) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return cred.user;
  }
}
