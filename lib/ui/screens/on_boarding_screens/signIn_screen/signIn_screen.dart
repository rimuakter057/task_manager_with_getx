
import 'package:flutter/material.dart';
import 'package:task_management_live_project/data/utils/app_text.dart';
import 'package:task_management_live_project/ui/screens/task_screens/nav_screen/nav_screen.dart';

import '../../../../data/utils/app_url.dart';
import '../../../../services/network_caller.dart';
import '../../../widget/snack_bar_message.dart';

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
  bool   _signInProgress=false;
  Widget gap = const SizedBox(height: 15,);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50,),
            Text(AppTexts.signInHeadline,style: Theme.of(context).textTheme.titleLarge,),
            gap,
              _buildTextForm()
          ],),
        ),
      ),
    );
  }

  Form _buildTextForm() {
    return Form(
            key: _formKey,
              child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                 hintText: AppTexts.emailHint,
                ),
                validator: (String? value){
                  if(value == null || value.isEmpty){
                    return AppTexts.emailError;
                  }
                  return null;
                },
              ),
              gap,
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
              gap,
              ElevatedButton(onPressed: _onTapSignUp,
                  child: const Text(AppTexts.signIn)),
            ],
          ));
  }

  //on tap sign up
  void _onTapSignUp(){
    if(_formKey.currentState?.validate()??false){
      _registerUser();
      Navigator.pushAndRemoveUntil(context,   MaterialPageRoute(builder: (context) => NavScreen()),
              (_) => false);
    }
  }

//sign up api function
  Future <void> _registerUser() async{
    _signInProgress=false;
    setState(() {

    });
//body
    Map <String,dynamic> requestBody={
      "email":_emailController.text.trim(),
      "password":_passwordController.text,};

    final NetworkResponse response = await NetworkCaller.postRequest(url:Urls.signIn ,
        body: requestBody);
    _signInProgress=false;
    setState(() {

    });
    if(response.isSuccess){
      _clear();
      showSnackBar("Sign Up Successfully", context);

    }else{
      showSnackBar(response.errorMessage, context,);
    }
  }

  //clear
  void _clear(){
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

