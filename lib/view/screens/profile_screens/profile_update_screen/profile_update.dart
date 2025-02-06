import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_live_project/view/screens/task_screens/nav_screen/nav_screen.dart';
import '../../../../data/controllers/auth_controller.dart';
import '../../../../data/service/network_caller.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/url.dart';
import '../../../controller/update_profile_controller.dart';
import '../../../widget/circular_indicator.dart';
import '../../../widget/snack_bar_message.dart';

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
  final UpdateProfileController _updateProfileController = Get.find<UpdateProfileController>();

  bool _updateProfileInProgress = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController.text = AuthController.userModel?.email??"mail here";
    _firstNameController.text = AuthController.userModel?.firstName??"first name here";
    _lastNameController.text = AuthController.userModel?.lastName??"last name here";
    _mobileNumberController.text = AuthController.userModel?.mobile??"mobile here";
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Update Profile",
              style: textTheme.titleLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                _buildPhotoPicker(),
                const SizedBox(
                  width: 10,
                ),

              ],
            ),
            const SizedBox(
              height: 20,
            ),
            _buildTextForm(),
          ],
        ),
      ),
    ));
  }

  Form _buildTextForm() {
    return Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  enabled: false,
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
                  validator: (String? value) {
                    if(value?.trim().isEmpty??true){
                      return "first name can't be empty";
                    }return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    hintText: 'Last Name',
                  ),
                  validator: (String? value) {
                    if(value?.trim().isEmpty??true){
                      return "last name can't be empty";
                    }return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _mobileNumberController,
                  decoration: const InputDecoration(
                    hintText: 'Mobile Number',
                  ),
                  validator: (String? value) {
                    if(value?.trim().isEmpty??true){
                      return "number can't be empty";
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
                    hintText: 'Password',
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                GetBuilder<UpdateProfileController>(
                  builder: (controller) {
                    return Visibility(
                      visible: controller.updateProfileInProgress==false,
                      replacement: const CircularIndicator(),
                      child: ElevatedButton(onPressed:_onTapUpdate,
                          child: const Text("Update")


                      ),
                    );
                  }
                )
              ],
            ),
          );
  }

//build photo picker
  Widget _buildPhotoPicker() {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(

        // onTap: _pickImage,
      child: Container(
          height: 50,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.primaryColor,
            border: Border.all(color: AppColors.black.withOpacity(.05)),
          ),
          child: Center(
            child: Text(
             "photo",
              style: textTheme.bodySmall?.copyWith(color: AppColors.white),
            ),
          )
      ),
    );
  }

  //on tap
Future<void> _onTapUpdate()async{
    if(_formKey.currentState!.validate()){
      _updateProfile();
      debugPrint("success update");
   }else{
      debugPrint("update error");
    }
}

//update profile api function
  Future<void> _updateProfile() async {

    final bool isSuccess = await UpdateProfileController().updateProfile(
      _emailController.text.trim(),
      _firstNameController.text.trim(),
      _lastNameController.text.trim(),
      _mobileNumberController.text.trim(),
    );

    if (isSuccess) {
      _passwordController.clear();
      showSnackBar( "Profile Updated Successfully", context);
      Get.offAllNamed(NavScreen.routeName);
    }
    else {
      showSnackBar(UpdateProfileController().errorMessage!, context);
    }
  }
}

