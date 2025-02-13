
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_live_project/utils/app_text.dart';
import '../../../../data/models/task_list/task_list_status_json_model.dart';
import '../../../../data/models/task_list/task_list_status_model.dart';
import '../../../../utils/colors.dart';
import '../../../controller/task_controller/completed_controller/completed_task_list_controller.dart';
import '../../../controller/task_controller/completed_controller/delete_completed_task_controller.dart';
import '../../../controller/task_controller/completed_controller/update_completed_task_status_controller.dart';
import '../../../widget/app_bar.dart';
import '../../../widget/circular_indicator.dart';
import '../../../widget/snack_bar_message.dart';
import '../../../widget/task_item_widget.dart';
class TaskCompletedListScreen extends StatefulWidget {
  const TaskCompletedListScreen({super.key});
  static const routeName = '/task-completed-list-screen';

  @override
  State<TaskCompletedListScreen> createState() => _TaskCancelListScreenState();
}

class _TaskCancelListScreenState extends State<TaskCompletedListScreen> {
  TaskListStatusModel? taskListStatusModel;
  TaskModel taskModel = TaskModel();
  final CompletedTaskListController _completedTaskListController = Get.find<CompletedTaskListController>();
  final DeleteCompletedTaskController _deleteCompletedTaskController = Get.find<DeleteCompletedTaskController>();
  final UpdateCompletedTaskStatusController _updateCompletedTaskStatusController = Get.find<UpdateCompletedTaskStatusController>();
  String? _selectedValue;
  List taskStatusList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

// ui part==================

  //completed list
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
              onDeleteTask:_deleteTask ,
              editOnTap: () {
                _buildShowDialog(context, index,taskList);
              },

            );
          }),
    );
  }
  // // update task status dialog
  Future<dynamic> _buildShowDialog(BuildContext context, int index,List <TaskModel>taskList) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
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
                    Navigator.pop(
                        context); // Close the dialog without saving
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(

                  onPressed: () {
                    if (selectedValue != null && selectedValue!.isNotEmpty)
                    {
                      _updateTaskStatus(
                          taskList[index].sId ?? '',/*
                        newListStatusModel!.taskList![index].sId ??
                            '',*/
                          selectedValue ?? '');
                    }
                    else{
                      showSnackBar("Please select a status!", context);
                    }
                   Get.back();
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

  //function part==============

  // completed summary List api function get x
  Future<void> _getSummaryCompletedList() async {
    final bool isSuccess = await  _completedTaskListController.getSummaryCompletedList();
    if (!isSuccess) {
      Get.snackbar(
        backgroundColor: AppColors.primaryColor,
        "error",
        _completedTaskListController.errorMessage!,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
  // update task status api function get x
  Future<void> _updateTaskStatus(String taskId, String status)async {
    final bool isSuccess = await _updateCompletedTaskStatusController.updateTaskStatus(taskId, status);
    if (isSuccess) {
      Get.snackbar(
        backgroundColor: AppColors.primaryColor,
        "update status", "Task status updated successfully",
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        backgroundColor: AppColors.primaryColor,
        "error",
        _updateCompletedTaskStatusController.errorMessage!,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
  // delete task api function get x
  Future<void> _deleteTask(String taskId) async {
    final bool isSuccess = await _deleteCompletedTaskController.deleteTask(taskId);
    if (isSuccess) {
      Get.snackbar(
        backgroundColor: AppColors.primaryColor,
        AppTexts.success,
        "Task deleted successfully",
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        backgroundColor: AppColors.primaryColor,
        "error",
        _deleteCompletedTaskController.errorMessage!,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

}