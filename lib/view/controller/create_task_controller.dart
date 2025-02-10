
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/service/network_caller.dart';
import '../../utils/url.dart';




class CreateTaskController extends GetxController {
  bool _createTaskProgress = false;
  bool get createTaskProgress => _createTaskProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> createNewTask(String title, String description, String status) async {
    _createTaskProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "title": title,
      "description": description,
      "status": status
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
        body: requestBody, url: Urls.createTask);

    if (response.isSuccess) {
      _errorMessage = null;
      _createTaskProgress = false;
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _createTaskProgress = false;
    update();
    return false;
  }
}