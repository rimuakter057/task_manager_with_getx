
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_management_live_project/data/utils/app_text.dart';
import '../../../../data/utils/app_colors.dart';


class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  static const String routeName = '/pin-verification-screen';

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediumTitleStyle =Theme.of(context).textTheme.titleMedium;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          const SizedBox(height: 80),
          Text(AppTexts.pinHeadline, style: theme.textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            'Minimum 6 characters',
            style: mediumTitleStyle,
          ),
          const SizedBox(height: 15),
          const SizedBox(height: 20,),
          PinCodeTextField(
            keyboardType: TextInputType.number,
            length: 6,
            pinTheme: PinTheme(
              errorBorderColor: AppColors.black,
              inactiveColor: AppColors.primaryColor,
              activeColor: AppColors.white,
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
            ),
            obscureText: false,
            backgroundColor: Colors.transparent,
            animationType: AnimationType.fade,
            animationDuration: const Duration(seconds: 8),
            appContext: context,
            onChanged: (value){},
            onCompleted: (value){},
          ),
          const SizedBox(height: 40,),
          ElevatedButton(
            onPressed: () {
              print("success");
             // Navigator.pushNamed(context, SetPasswordScreen.routeName);
            },
            child: const Text(
              "Confirm",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _buildSignInSection(),
        ],
        ),
      ),
    );

  }
  // build sign in section
  RichText _buildSignInSection() {
    return RichText(text: TextSpan(
        text: AppTexts.noAccount,
        style:Theme.of(context).textTheme.bodySmall,
        children: [
          TextSpan(
            text: AppTexts.signIn,
            style: TextStyle(
              color: AppColors.primaryColor,
            ),
            recognizer: TapGestureRecognizer()..onTap = (){
              print("Success");
              //Navigator.pop(context);
            },
          ),
        ]
    ),
    );
  }
// dispose

}

