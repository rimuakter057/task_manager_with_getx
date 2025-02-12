

  import 'package:get/get.dart';

import '../../../../data/models/task_list/task_list_status_json_model.dart';
import '../../../../data/models/task_list/task_list_status_model.dart';
import '../../../../data/service/network_caller.dart';
import '../../../../utils/url.dart';

class DeleteProgressTaskController extends GetxController {
  String? _errorMessage ;
  String? get errorMessage => _errorMessage;
  TaskListStatusModel? _taskListStatusModel;
  List <TaskModel> get taskList => _taskListStatusModel?.taskList ?? [];
  Future<bool> deleteTask(String taskId) async {
    bool isSuccess = false;
   update();
    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.deleteTask(taskId));
    if (response.isSuccess) {
        isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

   update();
   return isSuccess;
  }
}


