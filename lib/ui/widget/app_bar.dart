import 'package:flutter/material.dart';

import '../../data/utils/app_colors.dart';
import '../../data/utils/app_text.dart';
import '../../data/utils/assets_path.dart';
class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {

  const AppBarWidget({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(AssetPath.user,),
              ),
              Column(
                children: [
                  Text("User name",style: theme.textTheme.titleLarge!.copyWith(color: AppColors.white),),
                  Text(AppTexts.emailHeadline,style: theme.textTheme.bodyMedium!.copyWith(color: AppColors.white),),
                ],
              ),
            ],
          ),
          IconButton(onPressed: (){},
              icon:Icon(Icons.logout,color: AppColors.white,) ),
        ],),
    );
  }
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}