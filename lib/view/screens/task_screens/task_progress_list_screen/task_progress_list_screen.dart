
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_live_project/utils/app_text.dart';

import '../../../../data/models/task_list/task_list_status_json_model.dart';
import '../../../../data/models/task_list/task_list_status_model.dart';
import '../../../../data/service/network_caller.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/url.dart';
import '../../../widget/app_bar.dart';
import '../../../widget/snack_bar_message.dart';
import '../../../widget/task_item_widget.dart';
class TaskProgressListScreen extends StatefulWidget {
  const TaskProgressListScreen({super.key});
  static const routeName = '/task-cancel-list-screen';

  @override
  State<TaskProgressListScreen> createState() => _TaskCancelListScreenState();
}

class _TaskCancelListScreenState extends State<TaskProgressListScreen> {
  TaskListStatusModel? taskListStatusModel;
  TaskModel taskModel = TaskModel();
  bool _getProgressTaskListInProgress    = false;
  bool _taskStatusInProgress = true;
  String? _selectedValue;
  List taskStatusList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTaskStatus();
    _getSummaryProgressList();
  }

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
                itemCount: taskListStatusModel?.taskList?.length ?? 0,
                itemBuilder: (context, index) {
                  return TaskItemWidget(
                    status: AppTexts.progress,
                    color: AppColors.purple,
                    taskModel: taskListStatusModel!.taskList![index],
             /*       onTap: () {
                      _deleteTask(taskListStatusModel!.taskList![index].sId ?? '');
                      setState(() {

                      });
                    }, */
                    onDeleteTask:_deleteTask ,
                    editOnTap: () {
                    _buildShowDialog(context, index);
                  },

                  );
                }),
          ),
        ],
      ),
    );
  }
  // Function to show the dialog
  Future<dynamic> _buildShowDialog(BuildContext context, int index) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // Local variable to manage state inside the dialog
        String? selectedValue = _selectedValue;
        debugPrint("show dialog done");
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            debugPrint("Stateful builder done");
            return AlertDialog(
              title: const Text('Update Task Status'),
              content: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  hintText: 'Choose status',
                ),
                value: selectedValue, // Use local value here
                items: <String>[
                  'New',
                  'Canceled',
                  'Completed',
                  'Progress'
                ].map((String value) {
                  debugPrint("start alert dialog");
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedValue =
                        newValue; // Update the local selected value
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an option';
                  }
                  return null;
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  /*  Navigator.pop(
                        context);*/ // Close the dialog without saving
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(

                  onPressed: () {
                    if (selectedValue != null) {
                      // Update the global value and close the dialog
                      _selectedValue = selectedValue;
                    }
                    print("alert dialog done");
                    _updateTaskStatus(
                        taskListStatusModel!.taskList![index].sId ??
                            '',
                        selectedValue ?? '');
                    Navigator.pop(context); // Close the dialog
                    print("close dialog done");
                  },
                  child: const Text(
                    'Update',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
  // completed summary List api function
  Future<void> _getSummaryProgressList() async {
    _getProgressTaskListInProgress      = true;
    setState(() {});
    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.taskStatusList(AppTexts.progress));

    if(response.isSuccess){
      taskListStatusModel =
          TaskListStatusModel.fromJson(response.responseData!);
      setState(() {

      });
    }else{
      showSnackBar(response.errorMessage, context);
    }
    _getProgressTaskListInProgress   = false;
    setState(() {});
  }

  // delete task api function
  Future<void> _deleteTask(String taskId) async {
    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.deleteTask(taskId));
    if (response.isSuccess) {
      debugPrint("success");
    }else{
      debugPrint("fail");
    }

  }

  // delete task api function get x
  /*Future<void> _deleteTask(String taskId) async {
    final bool isSuccess = await _deleteNewTaskController.deleteTask(taskId);
    if (isSuccess) {
      showSnackBar("Task deleted successfully", context);
    } else {
      showSnackBar(_newTaskController.errorMessage!, context);
    }
  }*/








  //add task status in list
  Future<void> fetchTaskStatus() async {
    try {
      taskStatusList = await _getTaskStatus();
      setState(() {
        _taskStatusInProgress = false;
      });
    } catch (e) {
      setState(() {
        _taskStatusInProgress = false;
      });
      showSnackBar('Error fetching tasks: $e', context);
    }
  }

  //get task status api function
  Future<List<TaskModel>> _getTaskStatus() async {
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.taskStatusList('New'));
    if (response.isSuccess) {
      final List<dynamic> data = response.responseData?['data'] ?? [];
      return data.map((task) => TaskModel.fromJson(task)).toList();
    } else {
      throw Exception(response.errorMessage);
    }
  }

// update task status api function
  Future<void> _updateTaskStatus(String taskId, String status) async {
    _taskStatusInProgress = false;
    setState(() {});
    final response =
    await NetworkCaller.getRequest(url: Urls.updateTask(taskId, status));
    if (response.isSuccess) {
      showSnackBar("Task status updated successfully", context);
    } else {
      showSnackBar('Task status updated failed', context);
    }
    _taskStatusInProgress = true;
    setState(() {});
  }
}
