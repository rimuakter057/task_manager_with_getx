import 'package:get/get.dart';
import 'package:task_management_live_project/view/controller/auth_controller/sign_in_controller.dart';
import 'package:task_management_live_project/view/controller/profile_controller/update_profile_controller.dart';
import '../../view/controller/create_task_controller.dart';
import '../../view/controller/task_controller/canceled_controller/canceled_task_list_controller.dart';
import '../../view/controller/task_controller/canceled_controller/delete_canceled_task_controller.dart';
import '../../view/controller/task_controller/canceled_controller/update_canceled_task_status_controller.dart';
import '../../view/controller/task_controller/completed_controller/completed_task_list_controller.dart';
import '../../view/controller/task_controller/completed_controller/delete_completed_task_controller.dart';
import '../../view/controller/task_controller/completed_controller/update_completed_task_status_controller.dart';
import '../../view/controller/task_controller/new_controller/delete_new_task_controller.dart';
import '../../view/controller/get_summary_status_controller.dart';
import '../../view/controller/task_controller/new_controller/new_task_list_controller.dart';
import '../../view/controller/auth_controller/recover_email_controller.dart';
import '../../view/controller/auth_controller/recover_otp_controller.dart';
import '../../view/controller/auth_controller/set_password_controller.dart';
import '../../view/controller/auth_controller/signup_controller.dart';
import '../../view/controller/task_controller/new_controller/update_new_task_status_controller.dart';
import '../../view/controller/task_controller/progress_controller/delete_progress_task_controller.dart';
import '../../view/controller/task_controller/progress_controller/progress_task_list_controller.dart';
import '../../view/controller/task_controller/progress_controller/update_progress_task_status_controller.dart';


class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => SignUpController());
    Get.lazyPut(() => UpdateProfileController());
    Get.lazyPut(() =>  CreateTaskController());
    Get.put(NewTaskListController());
    Get.put(GetSummaryCountStatusController());
    Get.lazyPut(() => RecoverEmailController());
    Get.lazyPut(() => RecoverOtpController());
    Get.lazyPut(() => SetPasswordController());
    Get.lazyPut(() => CanceledTaskListController());
    Get.lazyPut(() => CompletedTaskListController());
    Get.lazyPut(() => ProgressTaskListController());
    Get.lazyPut(() => DeleteNewTaskController());
    Get.lazyPut(() => DeleteCanceledTaskController());
    Get.lazyPut(() => DeleteCompletedTaskController());
    Get.lazyPut(() => DeleteProgressTaskController());
    Get.lazyPut(() => UpdateTaskStatusController());
    Get.lazyPut(() => UpdateCanceledTaskStatusController());
    Get.lazyPut(() => UpdateCompletedTaskStatusController());
    Get.lazyPut(() => UpdateProgressTaskStatusController());
  }
}