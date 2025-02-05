import 'package:flutter/material.dart';

import '../../../../utils/styles.dart';
class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  static const routeName = '/email-verification-screen';

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Get Started With",style: headTextStyle(),),
              Text("Learn With Ostad Platform",style: head2TextStyle(context:context),),
              const SizedBox(height: 10,),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Old Password',
                ),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'New Password',
                ),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Confirmed Password',
                ),
              ),

              const SizedBox(height: 10,),
              SizedBox(
                height: MediaQuery.sizeOf(context).height*.07,
                width: double.infinity,
                child: ElevatedButton(onPressed: (){},
                    style: appButtonStyle(),
                    child: Text("Login",style: buttonTextStyle(
                        context:context
                    ),)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
