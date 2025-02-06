import 'package:get/get.dart';
import 'package:task_management_live_project/view/controller/sign_in_controller.dart';
import 'package:task_management_live_project/view/controller/update_profile_controller.dart';

import '../../view/controller/create_task_controller.dart';
import '../../view/controller/signup_controller.dart';


class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => SignUpController());
    Get.lazyPut(() => UpdateProfileController());
    Get.lazyPut(() =>  CreateTaskController());
  }
}