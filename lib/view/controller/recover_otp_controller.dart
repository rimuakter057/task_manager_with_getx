

import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/service/network_caller.dart';
import '../../utils/app_text.dart';
import '../../utils/url.dart';
import '../widget/snack_bar_message.dart';

class RecoverOtpController extends GetxController {
  bool _recoveryOtpInProgress = false;
  bool get recoveryOtpInProgress=> _recoveryOtpInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> recoverVerifyOtp(TextEditingController otpController) async {
    bool isSuccess = false;
    _recoveryOtpInProgress = true;
 update();
    final prefs = await   SharedPreferences.getInstance();
    final email = prefs.getString("email");

    final otp=otpController.text.trim();
    final response = await NetworkCaller.getRequest(url: Urls.recoverVerifyOtp(email!, otp));
    if(response.isSuccess){
      await prefs.setString("otp", otp);
      print(otp);

      isSuccess = true;
      _errorMessage = null;
    }
    else{
      _errorMessage = response.errorMessage;
    }
    _recoveryOtpInProgress = false;
    update();
    return isSuccess;
  }


}