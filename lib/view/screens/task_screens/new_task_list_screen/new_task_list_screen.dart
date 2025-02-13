import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_live_project/data/models/task_count/task_count_model.dart';
import 'package:task_management_live_project/data/models/task_list/task_list_status_json_model.dart';
import 'package:task_management_live_project/data/models/task_list/task_list_status_model.dart';
import 'package:task_management_live_project/data/service/network_caller.dart';
import '../../../../data/models/task_count/task_count_json_model.dart';
import '../../../../utils/app_text.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/url.dart';
import '../../../controller/task_controller/new_controller/delete_new_task_controller.dart';
import '../../../controller/get_summary_status_controller.dart';
import '../../../controller/task_controller/new_controller/new_task_list_controller.dart';
import '../../../controller/task_controller/new_controller/update_new_task_status_controller.dart';
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
  final NewTaskListController _newTaskController = Get.find<NewTaskListController>();
  final DeleteNewTaskController _deleteNewTaskController = Get.find<DeleteNewTaskController>();
  final UpdateTaskStatusController _updateTaskStatusController = Get.find<UpdateTaskStatusController>();
   final GetSummaryCountStatusController _getSummaryCountStatusController= Get.find<GetSummaryCountStatusController>();
  String? _selectedValue;
  List taskStatusList = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchAllDataSequence();
    });
  }//

  Future<void> _fetchAllDataSequence() async {
    try {
      await  _getSummaryCountStatus() ;
      await _getSummaryNewList();
    } catch (e) {
      showSnackBar('Error fetching tasks: $e', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            _buildTaskSummaryStatus(_getSummaryCountStatusController.taskCountStatusList),
            GetBuilder<NewTaskListController>(
              builder: (controller) {
                return Visibility(
                    visible:controller.getNewTaskListInProgress == false,
                    replacement: const CircularIndicator(),
                    child: _buildTaskListview(controller.taskList));
              }
            )
          ],
        ),
      ),
    );
  }

  // ui part======================

  // summary status ui
  Widget _buildTaskSummaryStatus(List<TaskCountModel> taskCountStatusModel) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(_getSummaryCountStatusController.taskCountStatusList.isNotEmpty){
        _getSummaryCountStatusController.getSummaryCountStatus;
      }
    });

    return GetBuilder<GetSummaryCountStatusController>(
      builder: (controller) {
        return Visibility(
          visible: controller.taskStatusInProgress == false,
          replacement: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: taskCountStatusModel.length,
               // itemCount: taskCountStatusModel?.taskByStatusList?.length ?? 0,
                itemBuilder: (context, index) {
                  final TaskCountModel model =
                  taskCountStatusModel[index];
                //  taskCountStatusModel!.taskByStatusList![index];
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
    );
  }

  // task list view ui
 Widget _buildTaskListview(List <TaskModel>taskList) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount:taskList.length,
          itemBuilder: (context, index) {
            return TaskItemWidget(
              status: 'New',
              color: AppColors.blue,
              taskModel: taskList[index],
             onDeleteTask:_deleteTask ,
              editOnTap: () {
                debugPrint("on tap done");
                _buildShowDialog(context, index,taskList);
              },
            );
          }),
    );
  }

  // update status to show the dialog ui
  Future<dynamic> _buildShowDialog(BuildContext context, int index,List <TaskModel>taskList) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        String? selectedValue = _selectedValue;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
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
                   Get.back();// Close the dialog without saving
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
                          taskList[index].sId ?? '',
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

                    Navigator.pop(context); // Close the dialog
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

  // function part===============

  // get summary status api function get x
  Future<void> _getSummaryCountStatus() async {
    final bool isSuccess = await _getSummaryCountStatusController.getSummaryCountStatus();
    if (!isSuccess) {
      Get.snackbar('Error', _getSummaryCountStatusController.errorMessage!);
    }
  }
  //add task status in list
  Future<void> fetchTaskStatus() async {
    try {
      taskStatusList = await _getTaskStatus();
      setState(() {
      });
    } catch (e) {
      setState(() {
      });
      Get.snackbar('Error','Error fetching tasks: $e',);
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
  // New summary List api function get x
  Future<void> _getSummaryNewList() async {
    final bool isSuccess = await _newTaskController.getSummaryNewList();
    if (!isSuccess) {
      Get.snackbar(
        backgroundColor: AppColors.primaryColor,
        "error",
        _newTaskController.errorMessage!,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );

    }
  }
  // update task status api function get x
  Future<void> _updateTaskStatus(String taskId, String status)async {
    final bool isSuccess = await _updateTaskStatusController.updateTaskStatus(taskId, status);
    if (isSuccess) {
      Get.snackbar("update status", "Task status updated successfully", );
    } else {
      Get.snackbar(
        backgroundColor: AppColors.primaryColor,
        "error",
        _newTaskController.errorMessage!,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
  // delete task api function get x
  Future<void> _deleteTask(String taskId) async {
    final bool isSuccess = await _deleteNewTaskController.deleteTask(taskId);
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
        _deleteNewTaskController.errorMessage!,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
