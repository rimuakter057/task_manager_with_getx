import 'package:get/get.dart';
import 'package:task_management_live_project/view/controller/sign_in_controller.dart';
import 'package:task_management_live_project/view/controller/update_profile_controller.dart';
import '../../view/controller/create_task_controller.dart';
import '../../view/controller/delete_new_task_controller.dart';
import '../../view/controller/get_summary_status_controller.dart';
import '../../view/controller/new_task_list_controller.dart';
import '../../view/controller/recover_email_controller.dart';
import '../../view/controller/recover_otp_controller.dart';
import '../../view/controller/set_password_controller.dart';
import '../../view/controller/signup_controller.dart';
import '../../view/controller/task_controller/update_task_status_controller.dart';


class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => SignUpController());
    Get.lazyPut(() => UpdateProfileController());
    Get.lazyPut(() =>  CreateTaskController());
    Get.put(NewTaskListController());
    Get.put(GetSummaryStatusController ());
    Get.lazyPut(() => RecoverEmailController());
    Get.lazyPut(() => RecoverOtpController());
    Get.lazyPut(() => SetPasswordController());
    Get.lazyPut(() => DeleteNewTaskController());
    Get.lazyPut(() => UpdateTaskStatusController());

  }
}