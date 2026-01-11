import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/dahboard/student_dashboard_screen.dart';
import 'features/dahboard/teacher_dashboard_screen.dart';
import 'firebase_options.dart';

import 'package:madrasati_app/core/routes/app_routes.dart';
import 'package:madrasati_app/core/theme/app_colors.dart';

import 'package:madrasati_app/features/role_selection/role_selection_screen.dart';
import 'package:madrasati_app/features/auth/student_login_screen.dart';
import 'package:madrasati_app/features/auth/teacher_login_screen.dart';


import 'package:madrasati_app/features/teacher/attendance_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MadrasatiApp());
}

class MadrasatiApp extends StatelessWidget {
  const MadrasatiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Madrasati',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.roleSelection,
      routes: {
        AppRoutes.roleSelection: (_) => const RoleSelectionScreen(),
        AppRoutes.studentLogin: (_) => const StudentLoginScreen(),
        AppRoutes.teacherLogin: (_) => const TeacherLoginScreen(),
        AppRoutes.studentDashboard: (_) => const StudentDashboardScreen(),
        AppRoutes.teacherDashboard: (_) => const TeacherDashboardScreen(),
      
        
        AppRoutes.attendance: (_) => const AttendanceScreen(classId: '',),
      },
    );
  }
}
