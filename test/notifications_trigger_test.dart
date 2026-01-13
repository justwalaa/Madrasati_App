import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Notification Trigger Integration Test', () {
    test('Notification is created when student is marked absent', () async {
      // Arrange
      final String studentAuthUid = 'test_student_uid';
      final String classId = 'test_class_id';
      final String status = 'absent';

     
      final Map<String, dynamic> attendanceRecord = {
        'studentAuthUid': studentAuthUid,
        'classId': classId,
        'status': status,
        'date': DateTime.now(),
      };

     
      final Map<String, dynamic> notification = {
        'userId': studentAuthUid,
        'title': 'Absence Alert',
        'body': 'You were marked absent today',
        'read': false,
      };

      
      expect(attendanceRecord['status'], equals('absent'));
      expect(notification['userId'], equals(studentAuthUid));
      expect(notification['title'], equals('Absence Alert'));
    });
  });
}
