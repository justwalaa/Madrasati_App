import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ================= Assignments =================
  Stream<QuerySnapshot> getAssignmentsByClass(String classId) {
    return _db
        .collection('assignments')
        .where('classId', isEqualTo: classId)
        .snapshots();
  }

  // ================= Attendance =================
  Future<void> saveAttendance({
    required String studentId,
    required String classId,
    required DateTime date,
    required String status,
  }) async {
    await _db.collection('attendance').add({
      'studentId': studentId,
      'classId': classId,
      'date': Timestamp.fromDate(date),
      'status': status,
    });

    if (status == 'absent') {
      await _db.collection('absence_logs').add({
        'studentId': studentId,
        'date': Timestamp.fromDate(date),
      });
    }
  }

  // ================= Absence Log =================
  Stream<QuerySnapshot> getAbsenceLog(String studentId) {
    return _db
        .collection('absence_logs')
        .where('studentId', isEqualTo: studentId)
        .orderBy('date', descending: true)
        .snapshots();
  }

  // ================= Notifications =================
  Future<void> addNotification({
    required String userId,
    required String message,
  }) async {
    await _db.collection('notifications').add({
      'userId': userId,
      'message': message,
      'createdAt': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getNotifications(String userId) {
    return _db
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
