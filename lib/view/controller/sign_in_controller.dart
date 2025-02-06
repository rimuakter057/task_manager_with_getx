

import 'package:get/get.dart';
import '../../data/controllers/auth_controller.dart';
import '../../data/models/user_model.dart';
import '../../data/service/network_caller.dart';
import '../../utils/url.dart';
import '../screens/task_screens/nav_screen/nav_screen.dart';

class SignInController extends GetxController {
  bool _signInProgress = false;
  bool get signInProgress => _signInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> signInUser(String email, String password) async {
    _signInProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email.trim(),
      "password": password,
    };

    final NetworkResponse response =
    await NetworkCaller.postRequest(body: requestBody, url: Urls.signIn);

    if (response.isSuccess) {
      String token = response.responseData!['token'];
      UserModel userModel = UserModel.fromJson(response.responseData!['data']);
      await AuthController.saveUserData(token, userModel);

      _errorMessage = null;
      _signInProgress = false;
      update();
      return true;
    } else {
      if (response.statusCode == 401) {
        _errorMessage = 'Invalid email or password';
      } else {
        _errorMessage = response.errorMessage;
      }
    }

    _signInProgress = false;
    update();
    return false;
  }
}

/*
class SignInController extends GetxController {
bool    _signInProgress=false;
bool get signInProgress => _signInProgress;
String? _errorMessage;
String? get errorMessage => _errorMessage;


  Future <bool> signInUser(String email,String password)async{
    bool isSuccess = false;
    _signInProgress=true;
       update();
    //add body
    Map<String,dynamic> requestBody = {
      "email":email.trim(),
      "password":password,
    };
    // api intention
    final NetworkResponse response = await NetworkCaller.postRequest(
        body: requestBody, url: Urls.signIn);
    if (response.isSuccess) {
      String token= response.responseData!['token'];
      UserModel userModel= UserModel.fromJson(response.responseData!['data']);
      await AuthController.saveUserData(token, userModel);
      isSuccess = true;
      _errorMessage = null;
      //Get.offAll(const NavScreen());
      //  Navigator.pushNamedAndRemoveUntil(context,  NavScreen.routeName,  (_) => false);


    }else{
      _signInProgress = false;
    update();
      if(response.statusCode==401){
        _errorMessage='Invalid email or password';
       // return showSnackBar(AppTexts.invalidMailPassword, context);
      }else{
        _errorMessage=response.errorMessage;
      }
     // return showSnackBar(response.errorMessage, context);
    }
    _signInProgress=false;
    update();
    return isSuccess;
  }
}
*/
