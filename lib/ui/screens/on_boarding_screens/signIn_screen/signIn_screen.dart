
import 'package:flutter/material.dart';
import 'package:task_management_live_project/data/utils/app_text.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
              ElevatedButton(onPressed: (){},
                  child: const Text(AppTexts.signIn)),
            ],
          ));
  }
  //dispose
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

