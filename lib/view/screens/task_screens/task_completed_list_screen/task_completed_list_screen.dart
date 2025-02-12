
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/task_list/task_list_status_json_model.dart';
import '../../../../data/models/task_list/task_list_status_model.dart';
import '../../../../data/service/network_caller.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/url.dart';
import '../../../controller/task_controller/completed_controller/completed_task_list_controller.dart';
import '../../../controller/task_controller/completed_controller/delete_completed_task_controller.dart';
import '../../../controller/task_controller/completed_controller/update_completed_task_status_controller.dart';
import '../../../widget/app_bar.dart';
import '../../../widget/circular_indicator.dart';
import '../../../widget/snack_bar_message.dart';
import '../../../widget/task_item_widget.dart';
class TaskCompletedListScreen extends StatefulWidget {
  const TaskCompletedListScreen({super.key});
  static const routeName = '/task-cancel-list-screen';

  @override
  State<TaskCompletedListScreen> createState() => _TaskCancelListScreenState();
}

class _TaskCancelListScreenState extends State<TaskCompletedListScreen> {
  TaskListStatusModel? taskListStatusModel;
  TaskModel taskModel = TaskModel();
  bool _getCompletedTaskListInProgress    = false;
  bool _taskStatusInProgress = true;
  final CompletedTaskListController _completedTaskListController = Get.find<CompletedTaskListController>();
  final DeleteCompletedTaskController _deleteCompletedTaskController = Get.find<DeleteCompletedTaskController>();
  final UpdateCompletedTaskStatusController _updateCompletedTaskStatusController = Get.find<UpdateCompletedTaskStatusController>();
  String? _selectedValue;
  List taskStatusList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTaskStatus();
    _getSummaryCompletedList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: Column(
        children: [

          GetBuilder<CompletedTaskListController>(
              builder: (controller) {
                return Visibility(
                  visible:controller.getCompletedTaskListInProgress == false,
                  replacement: const CircularIndicator(),
                  child: _buildTaskListView(controller.taskList),
                );
              }
          ),
        ],
      ),
    );
  }

  Widget _buildTaskListView(List <TaskModel>taskList) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount:taskList.length,
          itemBuilder: (context, index) {
            return TaskItemWidget(
              status: 'Completed',
              color: AppColors.primaryColor,
              taskModel: taskList[index],
              /*   onTap: () {
                          _deleteTask(taskListStatusModel!.taskList![index].sId ?? '');
                          setState(() {

                          });
                        },*/
              onDeleteTask:_deleteTask ,
              editOnTap: () {
                _buildShowDialog(context, index);
              },

            );
          }),
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
  /*Future<void> _getSummaryCompletedList() async {
    _getCompletedTaskListInProgress      = true;
    setState(() {});
    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.taskStatusList('Completed'));

    if(response.isSuccess){
      taskListStatusModel =
          TaskListStatusModel.fromJson(response.responseData!);
      setState(() {

      });
    }else{
      showSnackBar(response.errorMessage, context);
    }
    _getCompletedTaskListInProgress   = false;
    setState(() {});
  }*/

  // completed summary List api function get x
  Future<void> _getSummaryCompletedList() async {
    final bool isSuccess = await  _completedTaskListController.getSummaryCompletedList();
    if (!isSuccess) {
      showSnackBar( _completedTaskListController.errorMessage!, context);
    }
  }

  // delete task api function
/*  Future<void> _deleteTask(String taskId) async {
    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.deleteTask(taskId));
    if (response.isSuccess) {
      debugPrint("success");
    }else{
      debugPrint("fail");
    }

  }*/

  // delete task api function get x
  Future<void> _deleteTask(String taskId) async {
    final bool isSuccess = await _deleteCompletedTaskController.deleteTask(taskId);
    if (isSuccess) {
      showSnackBar("Task deleted successfully", context);
    } else {
      showSnackBar(_deleteCompletedTaskController.errorMessage!, context);
    }
  }










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
/*  Future<void> _updateTaskStatus(String taskId, String status) async {
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
  }*/
  // update task status api function get x
  Future<void> _updateTaskStatus(String taskId, String status)async {
    final bool isSuccess = await _updateCompletedTaskStatusController.updateTaskStatus(taskId, status);
    if (isSuccess) {
      Get.snackbar("update status", "Task status updated successfully", );
    } else {
      showSnackBar(_updateCompletedTaskStatusController.errorMessage!, context);
    }
  }
}