
import 'package:flutter/material.dart';
import 'package:task_management_live_project/data/utils/app_text.dart';

import '../../../../data/utils/app_colors.dart';

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
  bool _signUpProgress=false;

  @override
  Widget build(BuildContext context) {
    final textTheme= Theme.of(context).textTheme;
    Widget gap = const SizedBox(height: 15,);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:  const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Join With Us",
                style: textTheme.titleLarge,
              ),

             gap,
              _buildTextForm(),
            gap,

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
              hintText: AppTexts.emailHint,
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
              hintText:AppTexts.firstNameHint,
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
            controller: _passwordController,
            decoration: const InputDecoration(
              hintText: AppTexts.passwordHint,
            ),
            validator: (String? value){
              if(value == null || value.isEmpty){
                return AppTexts.passwordError;
              }
              return null;
            },
          ),
          // click button
          Visibility(
            visible: _signUpProgress==false,
            replacement: Center(child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),),
            child: ElevatedButton(

              onPressed: () {  },
              child:  Text(
                AppTexts.signUp
              ),
            ),
          ),
        ],
      ),
    );
  }





  // build sign in section
  RichText _buildSignInTextSection() {
    return RichText(text: TextSpan(
        text: "Already have an account?",
        style:Theme.of(context).textTheme.bodySmall,
        children: [
          TextSpan(
            text: "Sign In",
            style: TextStyle(
              color: AppColors.primaryColor,
            ),

          ),
        ]
    ),
    );
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
