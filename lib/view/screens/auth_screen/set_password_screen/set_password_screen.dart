import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_live_project/view/widget/circular_indicator.dart';
import '../../../../utils/app_text.dart';
import '../../../../utils/colors.dart';
import '../../../controller/auth_controller/set_password_controller.dart';
import '../../../widget/sign_in_up_section.dart';
import '../signIn_screen/sign_in_screen.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({
    super.key,
  });



  static const routeName = '/set-password-screen';

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmedPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final SetPasswordController _setPasswordController = Get.find<SetPasswordController>();

  late String email;
  late String otp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email')!;
    otp = prefs.getString('otp')!;
    debugPrint("save email======$email");
    debugPrint("save otp=========$otp");
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100,),
              Text(AppTexts.passHeadline, style: textTheme.titleLarge),
              const SizedBox(height: 4),
              Text(
                AppTexts.passHeadline2,
                style: textTheme.titleMedium,
              ),
              const SizedBox(height: 15),
              _buildTextForm(context),
              const SizedBox(
                height: 20,
              ),
              // build sign in section
              SignInUpSection(context: context)
            ],
          ),
        ),
      ),
    );
  }

  Form _buildTextForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              hintText: AppTexts.passwordHint,
            ),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return AppTexts.passwordError;
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _confirmedPasswordController,
            decoration: const InputDecoration(
              hintText: AppTexts.confirmedPasswordHint,
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return AppTexts.confirmedPasswordError;
              } else if (value != _passwordController.text) {
                return "confirmed password doesn't match";
              }

              return null;
            },
          ),
          const SizedBox(
            height: 40,
          ),
          GetBuilder<SetPasswordController>(
            builder: (controller) {
              return Visibility(
                visible:controller.setInProgress == false,
                replacement: const CircularIndicator(),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _setPasswordApi();
                      Get.snackbar(
                        backgroundColor: AppColors.primaryColor,
                        AppTexts.failed,"update failed" ,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                  child: const Text(
                   AppTexts.confirmedPasswordHint,
                  )

                ),
              );
            }
          ),
        ],
      ),
    );
  }

  //set api function

  Future<void> _setPasswordApi() async {
 bool isSuccess = await _setPasswordController.setPasswordApi(
   _passwordController.text
 );
    if (isSuccess) {
      Get.offAll(const SignInScreen());
      Get.snackbar(
        backgroundColor: AppColors.primaryColor,
        AppTexts.success,"update successful" ,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      } else {
      Get.snackbar(
        backgroundColor: AppColors.primaryColor,
        AppTexts.failed,"update failed" ,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      }
    }

  // dispose
  @override
  void dispose() {
    _passwordController.dispose();
    _confirmedPasswordController.dispose();
    super.dispose();
  }




}
