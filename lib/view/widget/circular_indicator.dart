import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class CircularIndicator extends StatelessWidget {
  const CircularIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(
      color: AppColors.primaryColor,
      strokeWidth: 5,
    ),);
  }
}