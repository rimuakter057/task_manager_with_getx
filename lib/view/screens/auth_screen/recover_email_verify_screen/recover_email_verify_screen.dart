import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_live_project/data/service/network_caller.dart';
import 'package:task_management_live_project/utils/app_text.dart';
import 'package:task_management_live_project/view/widget/circular_indicator.dart';
import '../../../../utils/url.dart';
import '../../../controller/recover_email_controller.dart';
import '../../../widget/sign_in_up_section.dart';
import '../../../widget/snack_bar_message.dart';
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
                  //Navigator.pop(context);
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
    }
   else if(!isSuccess){
      showSnackBar(AppTexts.emailError, context);
    }
  }


  //dispose
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
