import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_live_project/utils/colors.dart';
import 'package:task_management_live_project/view/controller/auth_controller/sign_in_controller.dart';
import 'package:task_management_live_project/view/screens/task_screens/nav_screen/nav_screen.dart';
import '../../../../utils/app_text.dart';
import '../../../widget/sign_in_up_section.dart';
import '../Signup_screen/signup_screen.dart';
import '../recover_email_verify_screen/recover_email_verify_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String routeName = '/signIn-screen';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SignInController _signInController = Get.find<SignInController>();
  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final bodySmallStyle = Theme.of(context).textTheme.bodySmall;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppTexts.signInHeadline,
                style: titleStyle,
              ),

              const SizedBox(
                height: 10,
              ),
              _buildTextForm(context),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  Get.toNamed(RecoverEmailVerifyScreen.routeName);
                },
                child: Text(AppTexts.forgotPass, style: bodySmallStyle),
              ),
              //sign up text section
              SignInUpSection(
                context: context,
                account: AppTexts.noAccount,
                text: AppTexts.signUp,
                onTap: () {
                  Get.offAllNamed(SignUpScreen.routeName);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

// sign in on tap
  void _signInOnTap() {
    if (_formKey.currentState!.validate()) {
      _signInUser();

    } else {
      Get.snackbar(
        backgroundColor: AppColors.primaryColor,
        AppTexts.failed,
        "SignIn failed",
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  //sign in form
  Form _buildTextForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
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
            height: 10,
          ),
          TextFormField(
            obscureText: true,
            controller: _passwordController,
            decoration: const InputDecoration(
              hintText: AppTexts.passwordHint,
            ),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return AppTexts.passwordError;
              }
              if (value!.length < 6) {
                return "password must be at least 6 characters";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 50,
          ),
          GetBuilder<SignInController>(builder: (controller) {
            return Visibility(
              visible: controller.signInProgress == false,
              replacement: Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              ),
              child: ElevatedButton(
                onPressed: _signInOnTap,
                child: const Text(
                  AppTexts.signIn,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // sign api function
  Future<void> _signInUser() async {
    final bool isSuccess = await _signInController.signInUser(
        _emailController.text.trim(), _passwordController.text);
    if (isSuccess) {
      Get.offAllNamed(NavScreen.routeName);
      _clearTextField();
    } else {
      Get.snackbar(
        backgroundColor: AppColors.primaryColor,
        AppTexts.failed,
        _signInController.errorMessage!,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  //clear text field
  void _clearTextField() {
    _emailController.clear();
    _passwordController.clear();
  }

  //dispose
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
