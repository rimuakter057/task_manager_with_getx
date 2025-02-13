
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_live_project/utils/app_text.dart';
import '../../../../data/models/task_list/task_list_status_json_model.dart';
import '../../../../data/models/task_list/task_list_status_model.dart';
import '../../../../utils/colors.dart';
import '../../../controller/task_controller/canceled_controller/canceled_task_list_controller.dart';
import '../../../controller/task_controller/canceled_controller/delete_canceled_task_controller.dart';
import '../../../controller/task_controller/canceled_controller/update_canceled_task_status_controller.dart';
import '../../../widget/app_bar.dart';
import '../../../widget/circular_indicator.dart';
import '../../../widget/task_item_widget.dart';

class TaskCancelListScreen extends StatefulWidget {
  const TaskCancelListScreen({super.key});
  static const routeName = '/task-cancel-list-screen';

  @override
  State<TaskCancelListScreen> createState() => _TaskCancelListScreenState();
}

class _TaskCancelListScreenState extends State<TaskCancelListScreen> {
  TaskListStatusModel? taskListStatusModel;
  TaskModel taskModel = TaskModel();
  String? _selectedValue;
  List taskStatusList = [];
  final CanceledTaskListController _canceledTaskListController = Get.find<CanceledTaskListController>();
  final DeleteCanceledTaskController _deleteCanceledTaskController = Get.find<DeleteCanceledTaskController>();
  final UpdateCanceledTaskStatusController _updateCanceledTaskStatusController = Get.find<UpdateCanceledTaskStatusController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSummaryCanceledList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: Column(
        children: [
          GetBuilder<CanceledTaskListController>(
            builder: (controller) {
              return Visibility(
                visible:controller.getCanceledTaskListInProgress == false,
                replacement: const CircularIndicator(),
                child: _buildTaskListView(controller.taskList),
              );
            }
          ),
        ],
      ),
    );
  }

//ui part=================

  //canceled list
  Widget _buildTaskListView(List <TaskModel>taskList) {
    return Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount:taskList.length,
                    itemBuilder: (context, index) {
                      return TaskItemWidget(
                        status: 'Canceled',
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
// update task status dialog
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
                      Get.snackbar(
                        backgroundColor: AppColors.primaryColor,
                        AppTexts.failed,
                        "Please select a status!",
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                    Get.back();// Close the dialog
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

  // canceled summary List api function get x
  Future<void> _getSummaryCanceledList() async {
    final bool isSuccess = await _canceledTaskListController.getSummaryCanceledList();
    if (!isSuccess) {
      Get.snackbar(
        backgroundColor: AppColors.primaryColor,
        "error",
        _canceledTaskListController.errorMessage!,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
  // update task status api function get x
  Future<void> _updateTaskStatus(String taskId, String status)async {
    final bool isSuccess = await _updateCanceledTaskStatusController.updateTaskStatus(taskId, status);
    if (isSuccess) {
      Get.snackbar("update status", "Task status updated successfully", );
    } else {
      Get.snackbar(
        backgroundColor: AppColors.primaryColor,
        "error",
        _updateCanceledTaskStatusController.errorMessage!,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );

    }
  }
  // delete task api function get x
  Future<void> _deleteTask(String taskId) async {
    final bool isSuccess = await _deleteCanceledTaskController.deleteTask(taskId);
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
        _deleteCanceledTaskController.errorMessage!,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
