import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_live_project/data/models/task_list/task_list_status_model.dart';

import '../../data/service/network_caller.dart';
import '../../utils/colors.dart';
import '../../utils/url.dart';
import '../controller/task_controller/new_controller/delete_new_task_controller.dart';

class TaskItemWidget extends StatelessWidget {

  const TaskItemWidget({
    super.key,
    required this.status,
    required this.color,
    this.deleteIconColor,
    this.editIconColor,
    required this.taskModel,
  this.editOnTap,
     this.onDeleteTask,
  });

  final String status;
  final Color color;
  final Color? deleteIconColor;
  final Color? editIconColor;
  final TaskModel taskModel;
  final Future<void> Function(String taskId) ?onDeleteTask;
  final void Function()? editOnTap;




  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
   return Card(
      elevation: 0,
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              taskModel.title ?? 'something wrong',
              style: theme.textTheme.titleMedium,
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              taskModel.description ?? 'something wrong',
              style: theme.textTheme.bodySmall,
            ),
            Text(
              taskModel.createdDate ?? 'something wrong',
              style: theme.textTheme.bodySmall,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  side: BorderSide(color: AppColors.grey),
                  label: Text(
                    status,
                    style: theme.textTheme.bodySmall!
                        .copyWith(color: Colors.white),
                  ),
                  backgroundColor: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: editOnTap,
                        icon: Icon(
                          Icons.edit,
                          color: editIconColor ?? AppColors.black,
                        )),
                    IconButton(
                        onPressed: onDeleteTask!=null?(){onDeleteTask!(taskModel.sId!);}:null,

                        icon: Icon(
                          Icons.delete,
                          color: deleteIconColor ?? AppColors.primaryColor,
                        )),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


