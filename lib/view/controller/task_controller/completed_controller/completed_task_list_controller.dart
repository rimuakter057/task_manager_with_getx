
import 'package:get/get.dart';
import 'package:task_management_live_project/data/models/task_list/task_list_status_json_model.dart';
import 'package:task_management_live_project/data/models/task_list/task_list_status_model.dart';
import '../../../../data/service/network_caller.dart';
import '../../../../utils/url.dart';

class CompletedTaskListController extends GetxController {
  bool _getCompletedTaskListInProgress = false;
  bool get getCompletedTaskListInProgress=> _getCompletedTaskListInProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  TaskListStatusModel? _taskListStatusModel;
  List <TaskModel> get taskList => _taskListStatusModel?.taskList ?? [];

  Future<bool> getSummaryCompletedList() async {
    bool isSuccess = false;
    _getCompletedTaskListInProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.taskStatusList('Completed'));
    if (response.isSuccess) {
      _taskListStatusModel = TaskListStatusModel.fromJson(response.responseData!);
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    _getCompletedTaskListInProgress = false;
    update();
    return isSuccess;
  }
}