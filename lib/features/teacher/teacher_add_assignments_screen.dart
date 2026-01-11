import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TeacherAddAssignmentScreen extends StatefulWidget {
  final String classId;
  const TeacherAddAssignmentScreen({super.key, required this.classId});

  @override
  State<TeacherAddAssignmentScreen> createState() => _TeacherAddAssignmentScreenState();
}

class _TeacherAddAssignmentScreenState extends State<TeacherAddAssignmentScreen> {
  final titleCtrl = TextEditingController();
  final subjectCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Assignment (${widget.classId})')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: subjectCtrl, decoration: const InputDecoration(labelText: 'Subject')),
            TextField(controller: descCtrl, decoration: const InputDecoration(labelText: 'Description')),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance.collection('assignments').add({
                  'classId': widget.classId,
                  'title': titleCtrl.text.trim(),
                  'subject': subjectCtrl.text.trim(),
                  'description': descCtrl.text.trim(),
                  'createdAt': Timestamp.now(),
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
