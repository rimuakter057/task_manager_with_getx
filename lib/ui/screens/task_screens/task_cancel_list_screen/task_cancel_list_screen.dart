
import 'package:flutter/material.dart';

import '../../../../data/utils/app_colors.dart';
import '../../../widget/app_bar.dart';
import '../../../widget/task_item_widget.dart';

class TaskCancelListScreen extends StatefulWidget {
  const TaskCancelListScreen({super.key});
  static const routeName = '/task-cancel-list-screen';

  @override
  State<TaskCancelListScreen> createState() => _TaskCancelListScreenState();
}

class _TaskCancelListScreenState extends State<TaskCancelListScreen> {
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
                    status: 'Cancel',
                    color: AppColors.primaryColor,
                  );
                }),
          ),
        ],
      ),
    );
  }
}
