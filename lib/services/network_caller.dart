import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class NetworkResponse {
  final Map<String, dynamic>? responseData;
  final String errorMessage;
  final int statusCode;
  final bool isSuccess;

  NetworkResponse({
    required this.statusCode,
    required this.isSuccess,
    this.responseData,
    this.errorMessage = 'Something went wrong!',
  });
}

class NetworkCaller {
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      Response response = await get(uri);
      debugPrint('statusCode => ${response.statusCode}');
      debugPrint('Response Data => ${response.body}');
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: true,
            responseData: decodedData);
      } else if (response.statusCode == 401) {
        return NetworkResponse(
            statusCode: response.statusCode, isSuccess: false);
      } else {
        return NetworkResponse(
            statusCode: response.statusCode, isSuccess: false);
      }
    } catch (e) {
      return NetworkResponse(
          statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }

  static Future<NetworkResponse> postRequest(
      {required String url, required Map<String, dynamic> body}) async {
    try {
      Uri uri = Uri.parse(url);
      Response response = await post(uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(body));

      debugPrint('statusCode => ${response.statusCode}');
      debugPrint('Response Data => ${response.body}');
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: true,
            responseData: decodedData);
      } else if (response.statusCode == 401) {
        return NetworkResponse(
            statusCode: response.statusCode, isSuccess: false);
      } else {
        return NetworkResponse(
            statusCode: response.statusCode, isSuccess: false);
      }
    } catch (e) {
      return NetworkResponse(
          statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }
}
