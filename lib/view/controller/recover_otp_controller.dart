

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



/*  Future<bool> recoverVerifyOtp(TextEditingController emailController) async {
    bool isSuccess = false;
    _recoveryOtpInProgress = true;
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
    _recoveryOtpInProgress = false;
    update();
    return isSuccess;
  }*/
  Future<bool> recoverVerifyOtp(TextEditingController otpController) async {
    bool isSuccess = false;
    _recoveryOtpInProgress = true;
 update();
    final prefs = await   SharedPreferences.getInstance();
    final email = prefs.getString("email");

  /*  if( email==null){
      showSnackBar(AppTexts.emailError, context);
      return;
    }*/

    final otp=otpController.text.trim();
    final response = await NetworkCaller.getRequest(url: Urls.recoverVerifyOtp(email!, otp));
    if(response.isSuccess){
      await prefs.setString("otp", otp);
      print(otp);
     // Get.offAll(const SetPasswordScreen());
      //   Navigator.pushNamedAndRemoveUntil(context, SetPasswordScreen.routeName,(value)=>false
      // arguments: email
      // );
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