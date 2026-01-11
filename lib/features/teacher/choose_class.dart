import 'package:flutter/material.dart';
import 'attendance_screen.dart';
import 'teacher_add_assignments_screen.dart';

class ChooseClassScreen extends StatelessWidget {
  final String? nextScreen;

  const ChooseClassScreen({
    super.key,
    this.nextScreen,
  });

  @override
  Widget build(BuildContext context) {
    final classes = ['1A', '1B', '2A', '2B'];

    return Scaffold(
      appBar: AppBar(title: const Text('Choose Class')),
      body: ListView.builder(
        itemCount: classes.length,
        itemBuilder: (context, index) {
          final classId = classes[index];

          return Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              title: Text('Class $classId'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                if (nextScreen == 'attendance') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AttendanceScreen(classId: classId),
                    ),
                  );
                } else if (nextScreen == 'assignment') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          TeacherAddAssignmentScreen(classId: classId),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
