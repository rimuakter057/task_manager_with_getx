
import 'package:flutter/material.dart';
import 'package:task_management_live_project/utils/colors.dart';

void showSnackBar(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: AppColors.primaryColor,
      duration: const Duration(seconds: 4),
    ),
  );

}