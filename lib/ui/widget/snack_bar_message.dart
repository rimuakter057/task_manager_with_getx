
import 'package:flutter/material.dart';

void showSnackBar(String message, BuildContext context,{bool isError=false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isError?Colors.red:Colors.green,
      duration: const Duration(seconds: 4),
    ),
  );

}