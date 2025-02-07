
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_live_project/utils/app_text.dart';
import 'package:task_management_live_project/view/controller/cancel_task_controller.dart';

import '../../../../data/models/task_list/task_list_status_json_model.dart';
import '../../../../data/models/task_list/task_list_status_model.dart';
import '../../../../data/service/network_caller.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/url.dart';
import '../../../widget/app_bar.dart';
import '../../../widget/snack_bar_message.dart';
import '../../../widget/task_item_widget.dart';

class TaskCancelListScreen extends StatefulWidget {
  const TaskCancelListScreen({super.key});
  static const routeName = '/task-cancel-list-screen';

  @override
  State<TaskCancelListScreen> createState() => _TaskCancelListScreenState();
}

class _TaskCancelListScreenState extends State<TaskCancelListScreen> {
  TaskListStatusModel? canceledListStatusModel;
  TaskModel taskModel = TaskModel();
  String? _selectedValue;
  List taskStatusList = [];
  bool _getCancelledTaskListInProgress   = false;
  bool _taskStatusInProgress = true;
 // final CancelTaskController _cancelTaskController=Get.find<CancelTaskController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTaskStatus();
    _getSummaryCancelledList();
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
                itemCount: canceledListStatusModel?.taskList?.length ?? 0,
                itemBuilder: (context, index) {
                  return TaskItemWidget(
                    status: 'Canceled',
                    color: AppColors.primaryColor,
                    taskModel: canceledListStatusModel!.taskList![index],
                    onTap: () {
                      _deleteTask(canceledListStatusModel!.taskList![index].sId ?? '');
                      setState(() {

                      });
                    }, editOnTap: () {
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
                        context); */// Close the dialog without saving
                  },
                  child: const Text(
                    AppTexts.cancel,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(

                  onPressed: () {
                    if (selectedValue != null) {
                      // Update the global value and close the dialog
                      _selectedValue = selectedValue;
                    }
                    _updateTaskStatus(
                        canceledListStatusModel!.taskList![index].sId ??
                            '',
                        selectedValue ?? '');
                    Navigator.pop(context); // Close the dialog
                   debugPrint("close dialog done");
                  },
                  child: const Text(
                    AppTexts.update,
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

  // cancelled summary List api function
/*  Future<void> _getSummaryCancelledList() async {
    final bool isSuccess = await _cancelTaskController.getSummaryCancelList();

    if (!isSuccess) {
      showSnackBar(_cancelTaskController.errorMessage!, context);
    }

  }*/

  Future<void> _getSummaryCancelledList() async {
    _getCancelledTaskListInProgress      = true;
    setState(() {});
    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.taskStatusList('Completed'));

    if(response.isSuccess){
      canceledListStatusModel =
          TaskListStatusModel.fromJson(response.responseData!);
      setState(() {

      });
    }else{
      showSnackBar(response.errorMessage, context);
    }
    _getCancelledTaskListInProgress    = false;
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
