
import 'package:flutter/material.dart';

import '../../../../data/utils/app_colors.dart';
import '../../../widget/app_bar.dart';
import '../../../widget/task_item_widget.dart';

class TaskCompletedListScreen extends StatefulWidget {
  const TaskCompletedListScreen({super.key});

  @override
  State<TaskCompletedListScreen> createState() => _TaskCompletedListScreenState();
}

class _TaskCompletedListScreenState extends State<TaskCompletedListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: Column(
        children: [

          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return TaskItemWidget(
                    title: 'Title',
                    subtitle: 'subtitle',
                    date: '8-12-2005',
                    status: 'completed',
                    color: AppColors.green,
                  );
                }),
          ),
        ],
      ),
    );
  }
}
