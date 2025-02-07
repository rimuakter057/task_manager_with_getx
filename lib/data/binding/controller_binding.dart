import 'package:get/get.dart';
import 'package:task_management_live_project/view/controller/cancel_task_controller.dart';
import 'package:task_management_live_project/view/controller/completed_task_controller.dart';
import 'package:task_management_live_project/view/controller/progress_task_controller.dart';
import 'package:task_management_live_project/view/controller/sign_in_controller.dart';
import 'package:task_management_live_project/view/controller/update_profile_controller.dart';

import '../../view/controller/create_task_controller.dart';

import '../../view/controller/new_task_controller.dart';
import '../../view/controller/signup_controller.dart';


class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => SignUpController());
    Get.lazyPut(() => UpdateProfileController());
    Get.lazyPut(() =>  CreateTaskController());
    Get.put(NewTaskController());
    Get.lazyPut(() => CancelTaskController());
    Get.lazyPut(() => CompletedTaskController());
    Get.lazyPut(() => ProgressTaskController());

  }
}