import 'package:flutter/material.dart';
import 'package:task_management_live_project/data/utils/app_colors.dart';
import 'package:task_management_live_project/data/utils/assets_path.dart';

import '../new_task_list_screen/add_new_task_screen/add_new_task_screen.dart';
import '../new_task_list_screen/new_task_list_screen.dart';
import '../task_cancel_list_screen/task_cancel_list_screen.dart';
import '../task_completed_list_screen/task_completed_list_screen.dart';
import '../task_progress_list_screen/task_progress_list_screen.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});
  static const routeName = '/nav-screen';

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _selectedIndex = 0;

  List<Widget> _screens = [
    NewTaskListScreen(),
    TaskCompletedListScreen(),
    TaskCancelListScreen(),
    TaskProgressListScreen(),
    TaskCancelListScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            _selectedIndex = index;
            setState(() {});
          },
          destinations: [
            NavigationDestination(
      icon: ColorFiltered(
      colorFilter: ColorFilter.mode(
      _selectedIndex == 0 ? AppColors.blue : AppColors.black,
        BlendMode.srcIn,
      ),
      child: Image.asset(AssetPath.newTask),
    ),
    label: 'New',
            ),
            NavigationDestination(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 1 ? AppColors.green : AppColors.black,
                  BlendMode.srcIn,
                ),
                child: Image.asset(AssetPath.completedTask),
              ),
              label: 'Completed',
            ),
            NavigationDestination(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 2 ? AppColors.primaryColor : AppColors.black,
                  BlendMode.srcIn,
                ),
                child: Image.asset(AssetPath.cancelTask),
              ),
              label: 'Canceled',
            ),
            NavigationDestination(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 3 ? AppColors.purple : AppColors.black,
                  BlendMode.srcIn,
                ),
                child: Image.asset(AssetPath.progressTask),
              ),
              label: 'Progress',
            ),
          ]),
      body: _screens[_selectedIndex],
    );
  }
}
