

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:task_management_live_project/data/binding/controller_binding.dart';
import 'package:task_management_live_project/theme/theme_styles.dart';
import 'package:task_management_live_project/view/screens/auth_screen/Signup_screen/signup_screen.dart';
import 'package:task_management_live_project/view/screens/auth_screen/recover_email_verify_screen/recover_email_verify_screen.dart';
import 'package:task_management_live_project/view/screens/auth_screen/recover_otp_verify_screen/recover_otp_verify_screen.dart';
import 'package:task_management_live_project/view/screens/auth_screen/set_password_screen/set_password_screen.dart';
import 'package:task_management_live_project/view/screens/auth_screen/signIn_screen/sign_in_screen.dart';
import 'package:task_management_live_project/view/screens/auth_screen/splash_screen.dart';
import 'package:task_management_live_project/view/screens/profile_screens/profile_update_screen/profile_update.dart';
import 'package:task_management_live_project/view/screens/task_screens/create_task_screen/create_task_screen.dart';
import 'package:task_management_live_project/view/screens/task_screens/nav_screen/nav_screen.dart';
import 'package:task_management_live_project/view/screens/task_screens/new_task_list_screen/new_task_list_screen.dart';


class TaskManagement extends StatelessWidget {
  const TaskManagement({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      initialBinding: ControllerBinding(),
      theme: theme,
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      onGenerateRoute: (RouteSettings settings) {
        late Widget widget;
        if (settings.name ==SplashScreen.routeName) {
          widget = const SplashScreen();
        }
        else if (settings.name == SignInScreen.routeName) {
          widget = const SignInScreen();
        } else if (settings.name == SignUpScreen.routeName) {
          widget = const SignUpScreen();
        } else if (settings.name ==RecoverEmailVerifyScreen .routeName) {
          widget = const RecoverEmailVerifyScreen ();
        }
        else if (settings.name ==ProfileUpdate .routeName) {
          widget = const ProfileUpdate ();
        }
        else if (settings.name == SetPasswordScreen.routeName) {
          widget = const SetPasswordScreen(
          );
        } else if (settings.name == RecoverOtpVerifyScreen.routeName) {
          widget =   const RecoverOtpVerifyScreen();
        }
        else if (settings.name == NavScreen.routeName) {
          widget = const NavScreen();
        } else if (settings.name == NewTaskListScreen.routeName) {
          widget = const NewTaskListScreen();
        } else if (settings.name == CreateTaskScreen.routeName) {
          widget = const CreateTaskScreen();
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





