import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/models/task_list/task_list_status_json_model.dart';
import '../../data/models/task_list/task_list_status_model.dart';
import '../../data/service/network_caller.dart';
import '../../utils/url.dart';

class ProgressTaskController extends GetxController {
  bool _getProgressTaskListInProgress = false;
  bool get getNewTaskListInProgress=> _getProgressTaskListInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  TaskListStatusModel? _taskListStatusModel;

  List <TaskModel> get taskList => _taskListStatusModel?.taskList ?? [];




  Future<bool> getSummaryNewList() async {
    bool isSuccess = false;
    _getProgressTaskListInProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.taskStatusList('Progress'));

    if (response.isSuccess) {
      _taskListStatusModel = TaskListStatusModel.fromJson(response.responseData!);
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }


    _getProgressTaskListInProgress = false;
    update();
    return isSuccess;
  }
}