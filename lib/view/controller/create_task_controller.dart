
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/service/network_caller.dart';
import '../../utils/url.dart';

/*class SignUpController extends GetxController {
  bool _signUpProgress = false;
  bool get signUpProgress => _signUpProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> registerUser(String email, String firstName, String lastName, String mobile, String password) async {
    _signUpProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email.trim(),
      "firstName": firstName.trim(),
      "lastName": lastName.trim(),
      "mobile": mobile.trim(),
      "password": password,
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.signUp, body: requestBody);

    if (response.isSuccess) {
      _errorMessage = null;
      _signUpProgress = false;
      update();
      return true;
    } else {
      if (response.statusCode == 400) {
        _errorMessage = "Invalid input or email already exists";
      } else {
        _errorMessage = response.errorMessage;
      }
    }

    _signUpProgress = false;
    update();
    return false;
  }
}*/


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