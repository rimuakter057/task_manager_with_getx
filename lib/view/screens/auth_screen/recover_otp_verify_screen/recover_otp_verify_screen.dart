import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_management_live_project/utils/app_text.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/styles.dart';
import '../../../controller/auth_controller/recover_otp_controller.dart';
import '../../../widget/circular_indicator.dart';
import '../../../widget/sign_in_up_section.dart';
import '../../../widget/snack_bar_message.dart';
import '../set_password_screen/set_password_screen.dart';

class RecoverOtpVerifyScreen extends StatefulWidget {
  const RecoverOtpVerifyScreen({super.key, });


  static const String routeName = '/recover-otp-screen';

  @override
  State<RecoverOtpVerifyScreen> createState() => _RecoverOtpVerifyScreenState();
}

class _RecoverOtpVerifyScreenState extends State<RecoverOtpVerifyScreen> {
  final TextEditingController _otpController = TextEditingController();

  final RecoverOtpController _recoverOtpController =
  Get.find<RecoverOtpController>();


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mediumTitleStyle = Theme.of(context).textTheme.titleMedium;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 80),
            Text(AppTexts.pinHeadline, style: textTheme.titleLarge),
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

            ),
            const SizedBox(
              height: 40,
            ),
            GetBuilder<RecoverOtpController>(
              builder: (controller) {
                return Visibility(
                      visible: controller.recoveryOtpInProgress== false,
                  replacement:const CircularIndicator(),
                  child: ElevatedButton(
                    onPressed: _confirmedOnTap,
                    child: const Text(
                      AppTexts.confirmed,
                    ),
                  ),
                );
              }
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
     debugPrint("otp controller here================${_otpController.text}");
    } else {
      Get.snackbar(
        backgroundColor: AppColors.primaryColor,
        AppTexts.failed,"otp failed" ,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }


  // 0tp api function
  Future<void> _recoverVerifyOtp() async {
    final bool isSuccess = await  _recoverOtpController.recoverVerifyOtp(_otpController);

    if(isSuccess){
      Get.toNamed(  SetPasswordScreen.routeName);
      Get.snackbar(
        backgroundColor: AppColors.primaryColor,
        AppTexts.success,"get otp successful" ,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    else if(!isSuccess){
      showSnackBar(AppTexts.otpFailed, context);
      Get.snackbar(
        backgroundColor: AppColors.primaryColor,
        AppTexts.otpFailed,_otpController.text ,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
