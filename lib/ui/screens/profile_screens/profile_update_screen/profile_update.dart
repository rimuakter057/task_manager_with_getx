
import 'package:flutter/material.dart';

import '../../../../data/utils/app_colors.dart';


class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({super.key});
  static const routeName = '/profile-update';


  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme= Theme.of(context).textTheme;
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: [
                  Text("Update Profile",style: textTheme.titleLarge,),
                const SizedBox(height: 10,),
            Row(
              children: [
                _buildPhotoPicker(),
                const SizedBox(width: 10,),
                Text("no photo select here",style: textTheme.bodySmall,)
              ],
            ),
                const SizedBox(height: 20,),
              Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                      hintText: 'First Name',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      hintText: 'Last Name',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _mobileNumberController,
                    decoration: const InputDecoration(
                      hintText: 'Mobile Number',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(onPressed: () {},
                      child: const Text("Update")),
                ],),
              ),

            ],),
          ),
        )
    );
  }

  Widget _buildPhotoPicker() {
    final textTheme= Theme.of(context).textTheme;
    return Container(
                padding: const EdgeInsets.symmetric(horizontal:15,vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primaryColor,
                    border: Border.all(color: AppColors.black.withOpacity(.05)),
                  ),
                  child: Text("photo",style: textTheme.bodySmall?.copyWith(color: AppColors.white),));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileNumberController.dispose();
  }
}