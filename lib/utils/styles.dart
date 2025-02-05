

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'colors.dart';

TextStyle headTextStyle({textColor}) {
  return TextStyle(
    color: textColor,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    fontFamily: 'Poppins',
  );
}

TextStyle head2TextStyle({context}) {
  return TextStyle(
    color: AppColors.black.withOpacity(.3),
    fontSize: MediaQuery.sizeOf(context).height*.02,
    fontWeight: FontWeight.w400,
    fontFamily: 'Poppins',
  );
}


TextStyle buttonTextStyle({context}) {
  return TextStyle(
    color: AppColors.white,
    fontSize: MediaQuery.sizeOf(context).height*.025,
    fontWeight: FontWeight.w400,
    fontFamily: 'Poppins',
  );
}

InputDecoration appInputDecoration(label) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.blueGrey.shade50,
    label: label,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
  );
}

ButtonStyle appButtonStyle() {
return ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  backgroundColor: AppColors.primaryColor,
fixedSize:const Size.fromWidth(double .maxFinite),

  padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
  foregroundColor: AppColors.white,
  textStyle: const TextStyle(
    fontSize: 20,
    fontFamily: 'poppins',
    fontWeight: FontWeight.w500
  )
);
}

Ink successButton(String buttonText){
  return Ink(
    decoration: BoxDecoration(
      color: AppColors.primaryColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Container(
      height: 45,
      alignment: Alignment.center,
      child: Text(buttonText),
    ),
  );
}

void showSuccess(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
}

void showError(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
}

PinTheme appPinTheme() {
  return PinTheme(
    errorBorderColor: AppColors.black,
    inactiveColor: AppColors.primaryColor,
    activeColor: AppColors.purple,
    shape: PinCodeFieldShape.box,
    borderRadius: BorderRadius.circular(5),
  );
}