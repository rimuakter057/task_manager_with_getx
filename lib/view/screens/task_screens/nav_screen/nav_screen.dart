
import 'package:flutter/material.dart';
import 'package:task_management_live_project/utils/app_text.dart';
import '../../../../utils/assets_path.dart';
import '../../../../utils/colors.dart';
import '../add_task_screen/add_task_screen.dart';
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

  final List <Widget>_screens=[
    const NewTaskListScreen(),
    const TaskCompletedListScreen(),
    const TaskCancelListScreen(),
    const TaskProgressListScreen(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            AddTaskScreen.routeName,
          );
        },
        child: const Icon(Icons.add),
      ),
       body:_screens[_selectedIndex],
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
              label: AppTexts.newT,
            ),
            NavigationDestination(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 1 ? AppColors.green : AppColors.black,
                  BlendMode.srcIn,
                ),
                child: Image.asset(AssetPath.completedTask),
              ),
              label: AppTexts.complete,
            ),
            NavigationDestination(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 2 ? AppColors.primaryColor : AppColors.black,
                  BlendMode.srcIn,
                ),
                child: Image.asset(AssetPath.cancelTask),
              ),
              label: AppTexts.cancel,
            ),
            NavigationDestination(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 3 ? AppColors.purple : AppColors.black,
                  BlendMode.srcIn,
                ),
                child: Image.asset(AssetPath.progressTask),
              ),
              label: AppTexts.progress,
            ),
          ]),
    );
  }
}
