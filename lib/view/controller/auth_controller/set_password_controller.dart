


import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/service/network_caller.dart';
import '../../../utils/url.dart';
import '../../widget/snack_bar_message.dart';

class SetPasswordController extends GetxController {
  bool _setInProgress = false;
  bool get setInProgress=> _setInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;


  Future<bool> setPasswordApi(String passwordController,) async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final otp = prefs.getString('otp');

    bool isSuccess = false;
    _setInProgress = true;
    update();
    final password = passwordController;

    final NetworkResponse response =

    await NetworkCaller.postRequest(url: Urls.recoverResetPassword, body: {
      "email":email,
      "OTP": otp,
      "password":password
    });
    debugPrint("password..................");
    if (response.isSuccess) {
      final responseData = response.responseData!;
      debugPrint("password..................11111111");
      if (responseData['status'] == 'success') {
        await prefs.remove('email');
        await prefs.remove('otp');
        debugPrint(password);
        isSuccess = true;
        debugPrint("password.........3333333333");
        _errorMessage = null;
      }
      else {
        debugPrint("password.........555553");
        debugPrint(response.responseData!['status']);
      }

    }
    else{ _errorMessage = response.errorMessage; }
    _setInProgress = false;
    update();
    return isSuccess;
  }
}