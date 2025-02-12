
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/models/task_list/task_list_status_json_model.dart';
import '../../../../data/models/task_list/task_list_status_model.dart';
import '../../../../utils/colors.dart';
import '../../../controller/task_controller/new_controller/update_new_task_status_controller.dart';
import '../../../controller/task_controller/progress_controller/delete_progress_task_controller.dart';
import '../../../controller/task_controller/progress_controller/progress_task_list_controller.dart';
import '../../../widget/app_bar.dart';
import '../../../widget/circular_indicator.dart';
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
  final ProgressTaskListController _progressTaskListController = Get.find<ProgressTaskListController>();
  final DeleteProgressTaskController _deleteProgressTaskController = Get.find<DeleteProgressTaskController>();
  final UpdateTaskStatusController _updateProgressTaskStatusController = Get.find<UpdateTaskStatusController>();
  String? _selectedValue;
  List taskStatusList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSummaryProgressList();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const AppBarWidget(),
      body: Column(
        children: [
          GetBuilder<ProgressTaskListController>(
              builder: (controller) {
                return Visibility(
                  visible:controller.getProgressTaskListInProgress == false,
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

  //progress task list
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
                      //  _selectedValue = selectedValue;

                      _updateTaskStatus(
                          taskList[index].sId ?? '',/*
                        newListStatusModel!.taskList![index].sId ??
                            '',*/
                          selectedValue ?? '');

                    }
                    else{
                      showSnackBar("Please select a status!", context);
                    }
                    print("alert dialog done");

                    /*_updateTaskStatus(
                        taskList[index].sId ?? '',*//*
                        newListStatusModel!.taskList![index].sId ??
                            '',*//*
                        selectedValue ?? '');*/
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


  //function part==============

  // canceled summary List api function get x
  Future<void> _getSummaryProgressList() async {
    final bool isSuccess = await _progressTaskListController.getSummaryProgressList();
    if (!isSuccess) {
      showSnackBar(_progressTaskListController.errorMessage!, context);
    }
  }
  // delete task api function get x
  Future<void> _deleteTask(String taskId) async {
    final bool isSuccess = await _deleteProgressTaskController.deleteTask(taskId);
    if (isSuccess) {
      showSnackBar("Task deleted successfully", context);
    } else {
      showSnackBar(_deleteProgressTaskController.errorMessage!, context);
    }
  }
  // update task status api function get x
  Future<void> _updateTaskStatus(String taskId, String status)async {
    final bool isSuccess = await _updateProgressTaskStatusController.updateTaskStatus(taskId, status);
    if (isSuccess) {
      Get.snackbar("update status", "Task status updated successfully", );
    } else {
      showSnackBar(_updateProgressTaskStatusController.errorMessage!, context);
    }
  }
}
