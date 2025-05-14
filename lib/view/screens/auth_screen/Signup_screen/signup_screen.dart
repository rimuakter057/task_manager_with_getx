
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_live_project/utils/app_text.dart';
import 'package:task_management_live_project/utils/colors.dart';
import '../../../../utils/styles.dart';
import '../../../controller/auth_controller/signup_controller.dart';
import '../../../widget/sign_in_up_section.dart';
import '../signIn_screen/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String routeName = '/signup-screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  final SignUpController _signUpController = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    final textTheme= Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:  const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 150,),
              Text(
               AppTexts.signUp,
             style: textTheme.titleLarge,
              ),
              Text(
                "Learn With Ostad Platform",
                style: head2TextStyle(context: context),
              ),
              const SizedBox(
                height: 10,
              ),
              _buildTextForm(),
              const SizedBox(
                height: 20,
              ),

              _buildSignInTextSection(),
            ],
          ),
        ),
      ),
    );
  }
//build text form
  Form _buildTextForm() {
    return Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText:AppTexts.emailHint ,
                    ),
                    validator: (String? value) {
                      if(value?.trim().isEmpty??true){
                        return AppTexts.emailError;
                      }return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                      hintText: AppTexts.firstNameHint,
                    ),
                    validator: (String? value) {
                      if(value?.trim().isEmpty??true){
                        return AppTexts.firstNameError;
                      }return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      hintText: AppTexts.lastNameHint,
                    ),
                    validator: (String? value) {
                      if(value?.trim().isEmpty??true){
                        return AppTexts.lastNameError;
                      }return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _mobileNumberController,
                    decoration: const InputDecoration(
                      hintText: AppTexts.mobileNumberHint,
                    ),
                    validator: (String? value) {
                      if(value?.trim().isEmpty??true){
                        return AppTexts.mobileNumberError;
                      }return null;
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
                      if(value?.trim().isEmpty??true){
                        return AppTexts.passwordError;
                      }if(value!.length<6){
                        return "password must be at least 6 characters";
                      }return null;
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  // click button
                  GetBuilder<SignUpController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.signUpProgress==false,
                        replacement: Center(child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),),
                        child: ElevatedButton(
                          onPressed:_onTapSignup,
                          child: const Text(
                            AppTexts.signUp,
                          ),
                        ),
                      );
                    }
                  ),

                ],
              ),
            );
  }


  //signup on tap
   void _onTapSignup() {
    if(_formKey.currentState!.validate()){
      _registerUser();
    }else{
      Get.snackbar(
        backgroundColor: AppColors.primaryColor,
        AppTexts.failed,
        _signUpController.errorMessage.toString(),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
   }

//signup api function get x
  Future<void> _registerUser()async{
     final bool isSuccess= await _signUpController.registerUser(
       _emailController.text.trim(),
       _firstNameController.text.trim(),
       _lastNameController.text.trim(),
       _mobileNumberController.text.trim(),
       _passwordController.text.trim(),
     );
    if (isSuccess) {
      _clearTextField();

      Get.offAllNamed(SignInScreen.routeName);
    }else{
      Get.snackbar(
        backgroundColor: AppColors.primaryColor,
        AppTexts.failed,"Sign Up Failed" ,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );

    }
  }

  //clear text field
  void _clearTextField(){
    _emailController.clear();
    _passwordController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _mobileNumberController.clear();
  }


  // build sign in section
  SignInUpSection _buildSignInTextSection() {
    return SignInUpSection(context: context);

  }

  // dispose
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }
}
