import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_management_live_project/utils/colors.dart';
import 'package:task_management_live_project/view/screens/on_boarding_screens/signIn_screen/signIn_screen.dart';
import '../../../controllers/auth_controller.dart';
import '../../widget/app_logo.dart';
import '../../widget/screen_background.dart';
import '../task_screens/nav_screen/nav_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // function to navigate to next screen
  @override
  void initState() {
    super.initState();
    nextScreen();
  }

  Future<void> nextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    bool isUserLoggedIn = await AuthController.isUserLoggedIn();
    if (isUserLoggedIn) {
      Get.offAllNamed(NavScreen.routeName);
   /*   Navigator.pushNamedAndRemoveUntil(
          context, NavScreen.routeName, (value) => false);*/
    } else {
      Get.offNamed(SignInScreen.routeName);
    //  Navigator.pushReplacementNamed(context, SignInScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenBackground(
      child: Center(
        child: Text(
          "TASK MANAGEMENT",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: AppColors.primaryColor),
        ),
      ),
    ));
  }
}
