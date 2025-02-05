import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_live_project/utils/app_text.dart';
import '../../../../data/service/network_caller.dart';
import '../../../../utils/styles.dart';
import '../../../../utils/url.dart';
import '../../../widget/sign_in_up_section.dart';
import '../../../widget/snack_bar_message.dart';
import '../set_password_screen/set_password_screen.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key, });
  //final String email;

  static const String routeName = '/pin-verification-screen';

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  TextEditingController _otpController = TextEditingController();
  bool _recoveryOtpInProgress = false;


  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final mediumTitleStyle = Theme.of(context).textTheme.titleMedium;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 80),
            Text('Pin Verification', style: titleStyle),
            const SizedBox(height: 4),
            Text(
              'Minimum 6 characters',
              style: mediumTitleStyle,
            ),
            const SizedBox(height: 15),
            const SizedBox(
              height: 20,
            ),
            PinCodeTextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              length: 6,
              pinTheme: appPinTheme(),
              backgroundColor: Colors.transparent,
              appContext: context,
             /* onChanged: (pin) {
                otpValue = pin;
              },*/
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: _confirmedOnTap,
              child: const Text(
                "Confirm",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // build sign in section
            SignInUpSection(context: context)
          ],
        ),
      ),
    );
  }


  //on tap
  void _confirmedOnTap() {

    if (_otpController.text.length == 6) {
      _recoverVerifyOtp();
     debugPrint(_otpController.text);
    } else {
    showSnackBar( AppTexts.otpFailed, context);
    }
  }


  // recover verify send email


  Future<void> _recoverVerifyOtp() async {
    _recoveryOtpInProgress = true;
    setState(() {
    });
    final prefs = await   SharedPreferences.getInstance();
    final email = prefs.getString("email");

    if( email==null){
      showSnackBar(AppTexts.emailError, context);
      return;
    }
    //final email = widget.email;
    final otp=_otpController.text.trim();
    final response = await NetworkCaller.getRequest(url: Urls.recoverVerifyOtp(email!, otp));
    if(response.isSuccess){
      await prefs.setString("otp", otp);
      print(otp);
      Get.offAll(const SetPasswordScreen());
   //   Navigator.pushNamedAndRemoveUntil(context, SetPasswordScreen.routeName,(value)=>false
        // arguments: email
     // );
      showSnackBar(AppTexts.mailSuccess, context);
    }
    else{
      showSnackBar(AppTexts.pinError, context);
    }
    _recoveryOtpInProgress = false;
    setState(() {

    });
  }



}
