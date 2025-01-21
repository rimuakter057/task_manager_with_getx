
import 'package:flutter/material.dart';

import '../../../../data/utils/app_colors.dart';
import '../../../widget/app_bar.dart';
import '../../../widget/task_item_widget.dart';

class TaskProgressListScreen extends StatefulWidget {
  const TaskProgressListScreen({super.key});
  static const routeName = '/task-progress-list-screen';

  @override
  State<TaskProgressListScreen> createState() => _TaskProgressListScreenState();
}

class _TaskProgressListScreenState extends State<TaskProgressListScreen> {
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
                    status: 'progress',
                    color: AppColors.purple,
                  );
                }),
          ),
        ],
      ),
    );
  }
}
