import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import '../../app.dart';
import '../../view/screens/auth_screen/signIn_screen/sign_in_screen.dart';
import '../controllers/auth_controller.dart';

class NetworkResponse {
  final int statusCode;
  final Map<String, dynamic>? responseData; // Map<String,dynamic keno>
  final String errorMessage;
  final bool isSuccess;
  NetworkResponse({
    required this.statusCode,
    required this.isSuccess,
    this.responseData,
    this.errorMessage = 'something went wrong',
  });
}

class NetworkCaller {
//get request

  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint("Uri = $url");
      Response response =
          await get(uri, headers: {'token': AuthController.accessToken ?? ''});
      if (response.statusCode == 200) {
        debugPrint("status = ${response.statusCode}");
        debugPrint("body = ${response.body}");
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedData,
        );
      } else if (response.statusCode == 401) {
      await _logout();
      return NetworkResponse(
          isSuccess: false, statusCode: response.statusCode);
    }
      else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
          statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }

//post request
  static Future<NetworkResponse> postRequest(
      {required Map<String, dynamic> body, required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint("Uri = $url");
      Response response = await post(uri,
          headers: {
            'content-type': 'application/json',
            'token': AuthController.accessToken ?? ''
          },
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        debugPrint("status code = ${response.statusCode}");
        final decodedData = jsonDecode(response.body);
        debugPrint(decodedData.toString());
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedData,
        );
      }
      if (response.statusCode == 401) {
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: false,
            errorMessage: "Unauthorized");
      }
      if (response.statusCode == 400) {
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: false,
            errorMessage: "bad request");
      } else if (response.statusCode == 401) {
        await _logout();
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode);
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
          statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }

  // logout
  static Future<void> _logout() async {
    await AuthController.clearUserData();

    Navigator.pushNamedAndRemoveUntil(
        TaskManagement.navigatorKey.currentContext!,
        SignInScreen.routeName,
        (_) => false);



  }
}
