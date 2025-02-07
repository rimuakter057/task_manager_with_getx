import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_management_live_project/data/models/task_count/task_count_model.dart';
import 'package:task_management_live_project/data/models/task_list/task_list_status_json_model.dart';
import 'package:task_management_live_project/data/models/task_list/task_list_status_model.dart';
import 'package:task_management_live_project/data/service/network_caller.dart';
import 'package:task_management_live_project/view/controller/new_task_controller.dart';
import 'package:task_management_live_project/view/widget/screen_background.dart';
import '../../../../data/models/task_count/task_count_json_model.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/url.dart';
import '../../../widget/app_bar.dart';
import '../../../widget/circular_indicator.dart';
import '../../../widget/snack_bar_message.dart';
import '../../../widget/task_item_widget.dart';
import '../../../widget/task_summary_widget.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});
  static const routeName = '/new-task-list-screen';

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  TaskModel taskModel = TaskModel();
  TaskListStatusModel? newListStatusModel;
  TaskCountStatusModel? taskCountStatusModel;
  bool _getTaskCountStatusInProgress = false;

  bool _deleteInProgress = false;
  bool _taskStatusInProgress = true;
  final NewTaskController _newTaskController = Get.find<NewTaskController>();

  String? _selectedValue;
  List taskStatusList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTaskStatus();
    _fetchAllDataSequence();
  } //

  Future<void> _fetchAllDataSequence() async {
    try {
      await _getSummaryStatus();
      await _getSummaryNewList();
    } catch (e) {
      showSnackBar('Error fetching tasks: $e', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: ScreenBackground(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            _buildTaskSummaryStatus(),
            GetBuilder<NewTaskController>(
              builder: (controller) {
                return Visibility(
                    visible:controller.getNewTaskListInProgress == false,
                    replacement: const CircularIndicator(),
                    child: _buildTaskListview(controller.taskList));
              }
            )
          ],
        ),
      )),
    );
  }

  Expanded _buildTaskListview(List<TaskModel> taskList) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: taskList.length,
          itemBuilder: (context, index) {
            return TaskItemWidget(
              status: 'New',
              color: AppColors.blue,
              taskModel: taskList[index],
              onTap: () {
                _deleteTask(newListStatusModel!.taskList![index].sId ?? '');
                setState(() {});
              },
              editOnTap: () {
                debugPrint("on tap done");
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
                items: <String>['New', 'Canceled', 'Completed', 'Progress']
                    .map((String value) {
                  debugPrint("start alert dialog");
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedValue = newValue; // Update the local selected value
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
                                  context); */ // Close the dialog without saving
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
                        newListStatusModel!.taskList![index].sId ?? '',
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

// summary status ui
  Widget _buildTaskSummaryStatus() {
    return Visibility(
      visible: _getTaskCountStatusInProgress == false,
      replacement: CircularProgressIndicator(
        color: AppColors.primaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: taskCountStatusModel?.taskByStatusList?.length ?? 0,
            itemBuilder: (context, index) {
              final TaskCountModel model =
                  taskCountStatusModel!.taskByStatusList![index];
              return TaskStatusSummaryCounterWidget(
                title: model.sId ?? '',
                count: model.sum.toString(),
              );
            },
          ),
        ),
      ),
    );
  }

  // get summary status api function
  Future<void> _getSummaryStatus() async {
    _getTaskCountStatusInProgress = true;
    setState(() {});
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.taskStatusCount);

    if (response.isSuccess) {
      taskCountStatusModel =
          TaskCountStatusModel.fromJson(response.responseData!);
      setState(() {});
    } else {
      showSnackBar(response.errorMessage, context);
    }
    _getTaskCountStatusInProgress = false;
    setState(() {});
  }

  // New summary List api function
  Future<void> _getSummaryNewList() async {
    final bool isSuccess = await _newTaskController.getSummaryNewList();

    if (!isSuccess) {
      showSnackBar(_newTaskController.errorMessage!, context);
    }

  }

  // delete task api function
  Future<void> _deleteTask(String taskId) async {
    _deleteInProgress = true;
    setState(() {});
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.deleteTask(taskId));
    if (response.isSuccess) {
      showSnackBar("Task deleted successfully", context);
    } else {
      debugPrint("fail");
      showSnackBar("Task deleted failed", context);
    }
    _deleteInProgress = false;
    setState(() {});
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
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.taskStatusList('New'));
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
