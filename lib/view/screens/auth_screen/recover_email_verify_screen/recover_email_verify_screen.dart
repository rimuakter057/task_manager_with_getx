import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_live_project/utils/app_text.dart';
import 'package:task_management_live_project/view/widget/circular_indicator.dart';
import '../../../../utils/colors.dart';
import '../../../controller/auth_controller/recover_email_controller.dart';
import '../../../widget/sign_in_up_section.dart';
import '../recover_otp_verify_screen/recover_otp_verify_screen.dart';


class RecoverEmailVerifyScreen extends StatefulWidget {
  const RecoverEmailVerifyScreen({super.key});

  static const routeName = '/forget-email-verify-screen';

  @override
  State<RecoverEmailVerifyScreen> createState() =>
      _RecoverEmailVerifyScreenState();
}

class _RecoverEmailVerifyScreenState extends State<RecoverEmailVerifyScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // bool _recoveryEmailInProgress = false;
  final RecoverEmailController _recoverEmailController =
      Get.find<RecoverEmailController>();

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final mediumTitleStyle = Theme.of(context).textTheme.titleMedium;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              Text(AppTexts.emailHeadline, style: titleStyle),
              const SizedBox(height: 4),
              Text(
                AppTexts.emailHeadline2,
                style: mediumTitleStyle,
              ),
              const SizedBox(height: 15),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: AppTexts.emailHint,
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return AppTexts.emailError;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    GetBuilder<RecoverEmailController>(builder: (controller) {
                      return Visibility(
                        visible: controller.recoveryEmailInProgress == false,
                        replacement: const CircularIndicator(),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _recoverVerifyEmail();
                            }
                          },
                          child: const Text(
                            AppTexts.continueT,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // sign in text section
              SignInUpSection(
                context: context,
                onTap: () {
                  Get.back();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  // recover verify send email api function get
  Future<void> _recoverVerifyEmail() async {
    final bool isSuccess = await _recoverEmailController
        .recoverVerifyEmail(_emailController);
    if(isSuccess){
      Get.toNamed(  RecoverOtpVerifyScreen.routeName);
      Get.snackbar(
        backgroundColor: AppColors.primaryColor,
        AppTexts.success,"otp send successful" ,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
   else if(!isSuccess){
      Get.snackbar(
        backgroundColor: AppColors.primaryColor,
        AppTexts.failed,
        AppTexts.emailError,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }


  //dispose
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
