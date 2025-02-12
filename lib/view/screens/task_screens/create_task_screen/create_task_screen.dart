import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_live_project/data/service/network_caller.dart';
import 'package:task_management_live_project/utils/app_text.dart';
import 'package:task_management_live_project/view/screens/task_screens/nav_screen/nav_screen.dart';
import 'package:task_management_live_project/view/widget/snack_bar_message.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/url.dart';
import '../../../controller/create_task_controller.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});
  static const routeName = '/create-task-screen';

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CreateTaskController _createTaskController = Get.find<CreateTaskController>();
 // bool _addNewTaskInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTexts.addTaskHeadline,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 25,
          ),
          _buildTextField(),
        ],
      ),
    ));
  }



  //clear text field
  void _clearTextField() {
    _titleController.clear();
    _descriptionController.clear();
  }

  //text form field
  Form _buildTextField() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Column(
            children: [
            /*  DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  hintText: 'choose status',

                ),
                value: _selectedValue, // Initial value (can be null)
                items: <String>['New', 'Canceled', 'Completed','Progress'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedValue = newValue; // Update the selected value
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an option';
                  }
                  return null;
                },
              ),*/
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(hintText: AppTexts.title),
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return AppTexts.titleError;
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _descriptionController,
                maxLines: 8,
                decoration:
                    const InputDecoration(hintText: AppTexts.description),
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return AppTexts.descriptionError;
                  }
                },
              ),
              const SizedBox(
                height: 25,
              ),

              GetBuilder<CreateTaskController>(
                builder: (controller) {
                  return Visibility(
                    visible:controller.createTaskProgress == false,
                    replacement: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            await _createNewTask();
                          }
                        },
                        child: const Text(AppTexts.continueT)),
                  );
                }
              ),

            ],
          ),
        ),
      ),
    );
  }

  //create new task Api function
  Future<void> _createNewTask() async {
    final bool isSuccess = await _createTaskController.createNewTask(
      _titleController.text.trim(),
      _descriptionController.text.trim(),
    );
    if (isSuccess) {
      _clearTextField();
      Get.offAllNamed(NavScreen.routeName);
      //Get.back();
      Get.snackbar('Success', 'Task Added Successfully');
    }
    else {
      Get.snackbar('Error', _createTaskController.errorMessage!);
    }

  }




  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }
}
