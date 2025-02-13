import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_live_project/utils/app_text.dart';
import '../../utils/colors.dart';
import '../screens/auth_screen/signIn_screen/sign_in_screen.dart';

class SignInUpSection extends StatelessWidget {
  const SignInUpSection({
    super.key,
    required this.context,
    this.onTap,
    this.text,
    this.account,
  });

  final BuildContext context;
  final void Function()? onTap;
  final String? text;
  final String? account;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: account ?? AppTexts.haveAccount,
          style: Theme.of(context).textTheme.bodySmall,
          children: [
            TextSpan(
              text: text ?? AppTexts.signIn,
              style: TextStyle(
                color: AppColors.primaryColor,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = onTap ??
                    () {
                      Get.offAllNamed(SignInScreen.routeName);
                    },
            ),
          ]),
    );
  }
}
