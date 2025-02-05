
class Urls{
  static const String _baseUrl = "http://35.73.30.144:2005/api/v1";
  static const String signUp = "$_baseUrl/Registration";
  static const String signIn = "$_baseUrl/Login";
  static const String createTask = "$_baseUrl/createTask";
  static const String taskStatusCount = "$_baseUrl/taskStatusCount";
  static  String taskStatusList(String status) =>"$_baseUrl/listTaskByStatus/$status";
  static  String deleteTask(String taskId) => "$_baseUrl/deleteTask/$taskId";
  static String updateTask(String taskId, String status)=>"$_baseUrl/updateTaskStatus/$taskId/$status";
  static  String recoverVerifyEmail(String email) => "$_baseUrl/RecoverVerifyEmail/$email";
  static  String recoverVerifyOtp(String email,String otp) => "$_baseUrl/RecoverVerifyOtp/$email/$otp";
  static const  String recoverResetPassword = "$_baseUrl/RecoverResetPassword";
  static const String updateProfile = "$_baseUrl/ProfileUpdate";
  static  String updateTaskStatus(String taskId,String status) => "$_baseUrl/updateTaskStatus/$taskId/$status";

}