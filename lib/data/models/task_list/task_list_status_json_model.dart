import 'package:task_management_live_project/data/models/task_list/task_list_status_model.dart';

class TaskListStatusModel {
  String? status;
  List<TaskModel>? taskList;

  TaskListStatusModel({this.status, this.taskList});

  TaskListStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskList = <TaskModel>[];
      json['data'].forEach((v) {
        taskList!.add(TaskModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (taskList != null) {
      data['data'] = taskList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

