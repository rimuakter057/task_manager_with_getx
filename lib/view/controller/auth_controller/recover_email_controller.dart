

import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/task_list/task_list_status_json_model.dart';
import '../../../data/models/task_list/task_list_status_model.dart';
import '../../../data/service/network_caller.dart';
import '../../../utils/url.dart';

class RecoverEmailController extends GetxController {
  bool _recoveryEmailInProgress = false;
  bool get recoveryEmailInProgress=> _recoveryEmailInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> recoverVerifyEmail(TextEditingController emailController) async {
    bool isSuccess = false;
    _recoveryEmailInProgress = true;
    update();
    String email = emailController.text.trim();
    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.recoverVerifyEmail(email));
    if (response.isSuccess) {
      final prefs=await SharedPreferences.getInstance();
      await prefs.setString("email", email);
      debugPrint(email);
      isSuccess = true;
      _errorMessage = null;
      //Get.toNamed( PinVerificationScreen.routeName);

     // showSnackBar(AppTexts.mailSuccess, context);

    }
    else{
      _errorMessage = response.errorMessage;
    }
    _recoveryEmailInProgress = false;
    update();
    return isSuccess;
  }


}