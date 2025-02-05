import 'package:flutter/material.dart';
import 'package:task_management_live_project/data/service/network_caller.dart';
import 'package:task_management_live_project/utils/app_text.dart';
import 'package:task_management_live_project/view/widget/snack_bar_message.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/url.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});
  static const routeName = '/add-new-task-screen';

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _selectedValue;
  bool _addNewTaskInProgress = false;
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

  Future<void> _createNewTask() async {
    _addNewTaskInProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "title": _titleController.text.trim(),
      "description": _descriptionController.text.trim(),
      "status": _selectedValue
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
        body: requestBody, url: Urls.createTask);
    _addNewTaskInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      showSnackBar(AppTexts.success, context);
      _clearTextField;
    } else {
      showSnackBar(response.errorMessage, context);
    }
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
              DropdownButtonFormField<String>(
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
              ),
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
              Visibility(
                visible: _addNewTaskInProgress == false,
                replacement: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                ),
                child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        await _createNewTask();
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(AppTexts.continueT)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }
}
