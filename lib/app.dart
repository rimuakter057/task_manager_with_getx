import 'package:flutter/material.dart';
import 'package:task_management_live_project/data/theme/app_theme.dart';
import 'package:task_management_live_project/ui/screens/on_boarding_screens/Signup_screen/signup_screen.dart';
import 'package:task_management_live_project/ui/screens/on_boarding_screens/pin_verification_screen/pin_verification_screen.dart';
import 'package:task_management_live_project/ui/screens/on_boarding_screens/signIn_screen/signIn_screen.dart';
import 'package:task_management_live_project/ui/screens/on_boarding_screens/splash_screen.dart';
import 'package:task_management_live_project/ui/screens/profile_screens/profile_update_screen/profile_update.dart';
import 'package:task_management_live_project/ui/screens/task_screens/nav_screen/nav_screen.dart';
import 'package:task_management_live_project/ui/screens/task_screens/new_task_list_screen/add_new_task_screen/add_new_task_screen.dart';
import 'package:task_management_live_project/ui/screens/task_screens/new_task_list_screen/new_task_list_screen.dart';

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  // This widget is the root of your application.
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: theme,
      debugShowCheckedModeBanner: false,
      initialRoute: SignInScreen.routeName,
      onGenerateRoute: (RouteSettings settings) {
        late Widget widget;
        if (settings.name == SplashScreen.routeName) {
          widget = const SplashScreen();
        }
        else if (settings.name == SignInScreen.routeName) {
          widget = const SignInScreen();
        } else if (settings.name == SignUpScreen.routeName) {
          widget = const SignUpScreen();
        } /*else if (settings.name ==ForgetEmailVerifyScreen.routeName) {
          widget = const ForgetEmailVerifyScreen();
        }*/ else if (settings.name ==  PinVerificationScreen.routeName) {
          widget = const PinVerificationScreen();
        } /*else if (settings.name == SetPasswordScreen.routeName) {
          widget = const  SetPasswordScreen();
        } */else if (settings.name == NavScreen.routeName) {
          widget = const NavScreen();
        } else if (settings.name == NewTaskListScreen.routeName) {
          widget = const NewTaskListScreen();
        } else if (settings.name == ProfileUpdate.routeName) {
          widget = const ProfileUpdate();
        }else if (settings.name == AddNewTaskScreen.routeName) {
          widget = const AddNewTaskScreen();
        }

        else {

          widget = const Scaffold(
            body: Center(
              child: Text("Page not found"),
            ),
          );
        }

        return MaterialPageRoute(builder: (context) => widget);
      },
    );
  }
}