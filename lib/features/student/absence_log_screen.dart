import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../data/services/auth_service.dart';

class AbsenceLogScreen extends StatelessWidget {
  const AbsenceLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = AuthService().currentUserId;

    if (uid == null) {
      return const Scaffold(
        body: Center(child: Text('User not logged in')),
      );
    }

    final q = FirebaseFirestore.instance
        .collection('attendance')
        .where('studentId', isEqualTo: uid)
        .where('status', isEqualTo: 'absent')
        .orderBy('date', descending: true);

    return Scaffold(
      appBar: AppBar(title: const Text('Absence Log')),
      body: StreamBuilder<QuerySnapshot>(
        stream: q.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No absences recorded 🎉'),
            );
          }

          return ListView.builder(
  padding: const EdgeInsets.all(12),
  itemCount: snapshot.data!.docs.length,
  itemBuilder: (context, index) {
    final d = snapshot.data!.docs[index];
    final date = (d['date'] as Timestamp).toDate();

    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.cancel, color: Colors.red),
        title: const Text(
          'Absent',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${date.day}/${date.month}/${date.year}',
        ),
      ),
    );
  },
);

        },
      ),
    );
  }
}
