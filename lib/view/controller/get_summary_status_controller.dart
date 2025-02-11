

import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/models/task_count/task_count_json_model.dart';
import '../../data/models/task_count/task_count_model.dart';
import '../../data/models/task_count/task_count_model.dart';
import '../../data/models/task_count/task_count_model.dart';
import '../../data/models/task_count/task_count_model.dart';
import '../../data/service/network_caller.dart';
import '../../utils/url.dart';

class GetSummaryStatusController extends GetxController {
  bool _taskStatusInProgress = false;
  bool get taskStatusInProgress=> _taskStatusInProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  TaskCountStatusModel? taskCountStatusModel;

  Future<bool> getSummaryStatus() async {
    bool isSuccess = false;
  _taskStatusInProgress = true;
 update();
    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.taskStatusCount);

    if (response.isSuccess) {
      taskCountStatusModel =
          TaskCountStatusModel.fromJson(response.responseData!);
     isSuccess = true;
    _errorMessage = null;
    } else {
        _errorMessage = response.errorMessage;
    }
   _taskStatusInProgress = false;
 update();
 return isSuccess;
  }

}

/*class NewTaskListController extends GetxController {
  bool _getNewTaskListInProgress = false;
  bool get getNewTaskListInProgress=> _getNewTaskListInProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  TaskListStatusModel? _taskListStatusModel;
  List <TaskModel> get taskList => _taskListStatusModel?.taskList ?? [];
  Future<bool> getSummaryNewList() async {
    bool isSuccess = false;
    _getNewTaskListInProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.taskStatusList('New'));
    if (response.isSuccess) {
      _taskListStatusModel = TaskListStatusModel.fromJson(response.responseData!);
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    _getNewTaskListInProgress = false;
    update();
    return isSuccess;
  }
}*/







/*class ProgressTaskController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;
  bool _inProgressTaskCount = false;
  bool get inProgressTaskCount => _inProgressTaskCount;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  TaskListByStatusModel? newTaskListModel;
  List<TaskModel> get taskList => newTaskListModel?.taskList ?? [];

  TaskCountByStatusModel? taskCountByStatusModel;

  Future<bool> getTaskCountingByStatus() async {
    bool isSuccess = false;
    _inProgressTaskCount = true;
    update();
    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.taskCountByStatus);
    if (response.isSuccess) {
      taskCountByStatusModel =
          TaskCountByStatusModel.fromJson(response.responseData!);
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgressTaskCount = false;
    update();
    return isSuccess;
  }


}*/





