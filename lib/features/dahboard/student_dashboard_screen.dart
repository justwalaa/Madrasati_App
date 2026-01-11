// ======================= STUDENT DASHBOARD =======================
// lib/features/dashboard/student_dashboard_screen.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/services/auth_service.dart';

class StudentDashboardScreen extends StatefulWidget {
  const StudentDashboardScreen({super.key});

  @override
  State<StudentDashboardScreen> createState() =>
      _StudentDashboardScreenState();
}

class _StudentDashboardScreenState extends State<StudentDashboardScreen> {
  String? studentName;
  String? classId;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadStudent();
  }

  Future<void> _loadStudent() async {
    final uid = AuthService().currentUserId;
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    setState(() {
      studentName = doc['fullName'];
      classId = doc['classId'];
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F2548),
        elevation: 0,
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          )
        ],
      ),
      drawer: const _StudentDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
            decoration: const BoxDecoration(
              color: Color(0xFF0F2548),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(Icons.school,
                          color: Colors.white, size: 30),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Madrasati',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Welcome Back!',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 4),
                Text(
                  '$studentName - Grade $classId',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          // Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: const [
                  _DashboardTile(
                      icon: Icons.event,
                      label: 'Activities',
                      color: Colors.amber),
                  _DashboardTile(
                      icon: Icons.menu_book,
                      label: 'Subjects',
                      color: Colors.purple),
                  _DashboardTile(
                      icon: Icons.schedule,
                      label: 'Exam Schedule',
                      color: Colors.blue),
                  _DashboardTile(
                      icon: Icons.grade,
                      label: 'Grades',
                      color: Colors.green),
                  _DashboardTile(
                      icon: Icons.chat,
                      label: 'Message Teacher',
                      color: Colors.cyan),
                  _DashboardTile(
                      icon: Icons.assessment,
                      label: 'Monthly Assessment',
                      color: Colors.pink),
                  _DashboardTile(
                      icon: Icons.calendar_today,
                      label: 'Class Schedule',
                      color: Colors.redAccent),
                  _DashboardTile(
                      icon: Icons.assignment,
                      label: 'Assignments',
                      color: Colors.orange),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _DashboardTile({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color.withOpacity(0.15),
            child: Icon(icon, color: color, size: 30),
          ),
          const SizedBox(height: 14),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}

class _StudentDrawer extends StatelessWidget {
  const _StudentDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: const [
          DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF0F2548)),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Student Menu',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          ListTile(leading: Icon(Icons.person), title: Text('Profile')),
          ListTile(
              leading: Icon(Icons.fact_check), title: Text('Attendance')),
          ListTile(
              leading: Icon(Icons.notifications), title: Text('Notifications')),
          Spacer(),
          ListTile(leading: Icon(Icons.logout), title: Text('Logout')),
        ],
      ),
    );
  }
}