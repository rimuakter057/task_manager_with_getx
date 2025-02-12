
import 'package:get/get.dart';
import 'package:task_management_live_project/data/models/task_list/task_list_status_json_model.dart';
import 'package:task_management_live_project/data/models/task_list/task_list_status_model.dart';
import '../../../../data/service/network_caller.dart';
import '../../../../utils/url.dart';

class NewTaskListController extends GetxController {
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
}


