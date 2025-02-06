
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/service/network_caller.dart';
import '../../utils/url.dart';

class UpdateProfileController extends GetxController {
  bool _updateProfileInProgress = false;
  bool get updateProfileInProgress => _updateProfileInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  Future<bool> updateProfile(String email, String firstName, String lastName, String mobile,{String? password}) async {
    _updateProfileInProgress = true;
     update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
    };

    if (password != null && password.isNotEmpty) {
      requestBody['password'] = password;}

    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.updateProfile, body: requestBody);
   /* _updateProfileInProgress = false;
    setState(() {});*/
    if (response.isSuccess) {
      _errorMessage = null;
      _updateProfileInProgress = false;
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _updateProfileInProgress = false;
    update();
    return false;
  }

}