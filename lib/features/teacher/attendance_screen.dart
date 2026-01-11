import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AttendanceScreen extends StatefulWidget {
  final String classId;
  const AttendanceScreen({super.key, required this.classId});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final Map<String, bool> attendance = {};
  bool _loading = true;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> students = [];

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    final classDoc = await FirebaseFirestore.instance
        .collection('classes')
        .doc(widget.classId)
        .get();

    final List studentsIds = classDoc.data()?['studentsIds'] ?? [];

    if (studentsIds.isEmpty) {
      setState(() => _loading = false);
      return;
    }

    final usersSnap = await FirebaseFirestore.instance
        .collection('users')
        .where(FieldPath.documentId, whereIn: studentsIds)
        .get();

    for (var d in usersSnap.docs) {
      attendance[d.id] = true; // default = present
    }

    setState(() {
      students = usersSnap.docs;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attendance - ${widget.classId}')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context, i) {
                      final student = students[i];
                      return CheckboxListTile(
                        title: Text(student['fullName']),
                        subtitle: Text(student['email'] ?? ''),
                        value: attendance[student.id],
                        onChanged: (v) {
                          setState(() {
                            attendance[student.id] = v ?? true;
                          });
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: _submitAttendance,
                    child: const Text('Submit Attendance'),
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> _submitAttendance() async {
    final batch = FirebaseFirestore.instance.batch();
    final now = Timestamp.now();

    attendance.forEach((studentId, isPresent) {
      final attendanceRef =
          FirebaseFirestore.instance.collection('attendance').doc();

      batch.set(attendanceRef, {
        'classId': widget.classId,
        'studentId': studentId,
        'date': now,
        'status': isPresent ? 'present' : 'absent',
      });

      if (!isPresent) {
        final notifRef =
            FirebaseFirestore.instance.collection('notifications').doc();

        batch.set(notifRef, {
          'userId': studentId,
          'title': 'Absence Alert',
          'body': 'You were marked absent today',
          'createdAt': now,
          'read': false,
        });
      }
    });

    await batch.commit();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Attendance saved successfully')),
    );

    Navigator.pop(context);
  }
}
