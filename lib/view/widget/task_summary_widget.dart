import 'package:flutter/material.dart';

import '../../data/service/network_caller.dart';
import '../../utils/colors.dart';
import '../../utils/url.dart';

class TaskStatusSummaryCounterWidget extends StatelessWidget {
  const TaskStatusSummaryCounterWidget({
    super.key, required this.title, required this.count,});
  final String title;
  final String count;



  @override
  Widget build(BuildContext context) {
    final  textTheme= Theme.of(context).textTheme;
    return Card(
        color: AppColors.white,
        child:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
          child: Column(children: [

            Text(count,style:textTheme.titleLarge,),
            Text(title,style: textTheme.titleMedium,),
          ],),
        )
    );
  }


}