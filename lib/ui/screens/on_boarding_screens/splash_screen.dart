import 'package:flutter/material.dart';
import 'package:task_management_live_project/ui/screens/on_boarding_screens/signIn_screen/signIn_screen.dart';
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
    await Future.delayed(const Duration(seconds: 1));
    /*bool isUserLoggedIn = await AuthController.isUserLoggedIn();
    if (isUserLoggedIn) {
      Navigator.pushReplacementNamed(context, NavScreen.routeName);
    }else*/{
      Navigator.pushReplacementNamed(context, SignInScreen.routeName);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(child: Text("TASK MANAGER",style: Theme.of(context).textTheme.titleLarge,)),

    );
  }
}




