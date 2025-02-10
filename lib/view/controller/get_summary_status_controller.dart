

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

  Future<bool> _getSummaryStatus() async {
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

/*
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
*/
