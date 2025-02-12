
import 'package:get/get.dart';
import 'package:task_management_live_project/data/models/task_list/task_list_status_json_model.dart';
import 'package:task_management_live_project/data/models/task_list/task_list_status_model.dart';
import '../../../../data/service/network_caller.dart';
import '../../../../utils/url.dart';

class CanceledTaskListController extends GetxController {
  bool _getCanceledTaskListInProgress = false;
  bool get getCanceledTaskListInProgress=> _getCanceledTaskListInProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  TaskListStatusModel? _taskListStatusModel;
  List <TaskModel> get taskList => _taskListStatusModel?.taskList ?? [];

  Future<bool> getSummaryCanceledList() async {
    bool isSuccess = false;
    _getCanceledTaskListInProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.taskStatusList('Canceled'));
    if (response.isSuccess) {
      _taskListStatusModel = TaskListStatusModel.fromJson(response.responseData!);
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    _getCanceledTaskListInProgress = false;
    update();
    return isSuccess;
  }
}
