
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/service/network_caller.dart';
import '../../utils/url.dart';




class CreateTaskController extends GetxController {
  bool _createTaskProgress = false;
  bool get createTaskProgress => _createTaskProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> createNewTask(String title, String description,) async {
    bool isSuccess = false;
    _createTaskProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "title": title,
      "description": description,
      "status":"New"
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
        body: requestBody, url: Urls.createTask);

    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    _createTaskProgress = false;
    update();
    return isSuccess;
  }





/*
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
*/

}








/*
class AddNewTaskController extends GetxController {
  bool _isProgressing = false;

  bool get isProgressing => _isProgressing;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> addNewTask(String title, String description) async {
    bool isSuccess = false;
    _isProgressing = true;
    update();
    Map<String, dynamic> requestBody = {
      'title': title,
      'description': description,
      'status': 'New',
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.addNewTask,
      body: requestBody,
    );
    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    _isProgressing = false;
    update();
    return isSuccess;
  }
}*/
