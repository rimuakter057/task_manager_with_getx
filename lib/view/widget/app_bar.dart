import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_live_project/view/screens/profile_screens/profile_update_screen/profile_update.dart';

import '../../data/controllers/auth_controller.dart';
import '../../utils/assets_path.dart';
import '../../utils/colors.dart';
import '../screens/auth_screen/signIn_screen/signIn_screen.dart';


class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
  this.fromUpdateProfile=false
  });

  final bool fromUpdateProfile;


  @override
  Widget build(BuildContext context) {
    final  textTheme= Theme.of(context).textTheme;
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      title: GestureDetector(
        onTap: (){

          if( fromUpdateProfile==false ){
            Get.toNamed(ProfileUpdate.routeName);

          }

        },
        child: Row(
          children: [
          const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(AssetPath.user,),
            ),
            Expanded(
              child: Column(children: [
                Text(AuthController.userModel?.fullName??"",style:textTheme.titleLarge?.copyWith(color: AppColors.white) ,),
                Text(AuthController.userModel?.email??"",style:textTheme.bodySmall?.copyWith(color: AppColors.white) ,),
              ],),
            ),
            IconButton(onPressed: ()async{
           await   AuthController.clearUserData();
              Navigator.pushNamedAndRemoveUntil(context, SignInScreen.routeName, (predicate)=>false);
            },
                icon:Icon(Icons.logout,color: AppColors.white,) ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}