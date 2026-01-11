import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../data/services/auth_service.dart';
import '../../data/services/user_services.dart';

class AssignmentsScreen extends StatefulWidget {
  const AssignmentsScreen({super.key});

  @override
  State<AssignmentsScreen> createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<AssignmentsScreen> {
  String? classId;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final uid = AuthService().currentUserId!;
    final cid = await UserService().getUserClassId(uid);
    setState(() => classId = cid);
  }

  @override
  Widget build(BuildContext context) {
    if (classId == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final q = FirebaseFirestore.instance
        .collection('assignments')
        .where('classId', isEqualTo: classId);

    return Scaffold(
      appBar: AppBar(title: const Text('Assignments')),
      body: StreamBuilder<QuerySnapshot>(
        stream: q.snapshots(),
        builder: (c, s) {
          if (!s.hasData) return const Center(child: CircularProgressIndicator());
          return ListView(
            children: s.data!.docs.map((d) {
              return ListTile(
                title: Text(d['title']),
                subtitle: Text(d['description']),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
