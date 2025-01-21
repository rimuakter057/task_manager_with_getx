import 'package:flutter/material.dart';
import 'package:task_management_live_project/data/utils/app_text.dart';
import '../../../../data/utils/app_colors.dart';
import '../../../widget/app_bar.dart';
import '../../../widget/task_item_widget.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: Column(
        children: [
          _buildTaskSummaryStatus(),
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
                    status: 'New',
                    color: AppColors.blue,
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskSummaryStatus() {
    final theme = Theme.of(context);
    return SizedBox(
      height: 60,
      child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      AppTexts.number,
                      style: theme.textTheme.bodyMedium,
                    ),
                    Text(
                      AppTexts.submit,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
