import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_live_project/data/service/network_caller.dart';
import 'package:task_management_live_project/view/screens/on_boarding_screens/signIn_screen/signIn_screen.dart';
import 'package:task_management_live_project/view/widget/circular_indicator.dart';
import 'package:task_management_live_project/view/widget/snack_bar_message.dart';

import '../../../../utils/app_text.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/url.dart';
import '../../../widget/sign_in_up_section.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({
    super.key,
  });

/*  final String otp;
  final String email;*/

  static const routeName = '/set-password-screen';

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmedPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _setInProgress = false;

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
    print(email);
    print(otp);
  }

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
              Text('Set Password', style: titleStyle),
              const SizedBox(height: 4),
              Text(
                'Minimum 6 characters',
                style: mediumTitleStyle,
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
              ;

              return null;
            },
          ),
          const SizedBox(
            height: 40,
          ),
          Visibility(
            visible: _setInProgress == false,
            replacement: const CircularIndicator(),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _setPasswordApi();
                }
                Get.toNamed(SignInScreen.routeName);

                // Navigator.pushNamed(context, SignInScreen.routeName);
              },
              child: const Text(
               AppTexts.confirmedPasswordHint,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //set api
  Future<void> _setPasswordApi() async {
    setState(() {
      _setInProgress = true;
    });
    final password = _passwordController.text.trim();

    final NetworkResponse response =
        await NetworkCaller.postRequest(url: Urls.recoverResetPassword, body: {
        "email":email,
        "OTP": otp,
        "password":password
    });
    if (response.isSuccess) {
      final responseData = response.responseData!;
      print(responseData);
      if (responseData['status'] == 'success') {
        debugPrint(password);
        Get.offAll(const SignInScreen());
       /* Navigator.pushNamedAndRemoveUntil(
            context, SignInScreen.routeName, (value) => false);*/
      } else {
        showSnackBar(responseData['status'], context);
        debugPrint(response.responseData!['status']);
      }
    } else {
      showSnackBar(response.errorMessage, context);
    }
    setState(() {
      _setInProgress = false;
    });
  }



  // dispose
  @override
  void dispose() {
    _passwordController.dispose();
    _confirmedPasswordController.dispose();
    super.dispose();
  }
}
