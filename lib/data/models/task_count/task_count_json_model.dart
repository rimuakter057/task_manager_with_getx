import 'package:task_management_live_project/data/models/task_count/task_count_model.dart';

class TaskCountStatusModel {
  String? status;
  List<TaskCountModel>? taskByStatusList;

  TaskCountStatusModel({this.status, this.taskByStatusList});

  TaskCountStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskByStatusList = <TaskCountModel>[];
      json['data'].forEach((v) {
        taskByStatusList!.add(new TaskCountModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.taskByStatusList != null) {
      data['data'] = taskByStatusList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


