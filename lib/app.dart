import 'package:flutter/material.dart';
import 'package:task_management_live_project/data/theme/app_theme.dart';
import 'package:task_management_live_project/data/utils/app_colors.dart';
import 'package:task_management_live_project/ui/screens/on_boarding_screens/Signup_screen/signup_screen.dart';
import 'package:task_management_live_project/ui/screens/on_boarding_screens/pin_verification_screen/pin_verification_screen.dart';
import 'package:task_management_live_project/ui/screens/on_boarding_screens/signIn_screen/signIn_screen.dart';
import 'package:task_management_live_project/ui/screens/task_screens/nav_screen/nav_screen.dart';
import 'package:task_management_live_project/ui/screens/task_screens/new_task_list_screen/add_new_task_screen/add_new_task_screen.dart';

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: PinVerificationScreen(),
    );
  }
}