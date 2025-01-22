import 'package:flutter/material.dart';
import 'package:task_management_live_project/data/utils/app_text.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});
  static const routeName = '/add-new-task-screen';

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Widget gap = const SizedBox(height: 15,);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50,),
              Text(AppTexts.addNewTaskHeadline,style: Theme.of(context).textTheme.titleLarge,),
              gap,
              _buildTextForm()
            ],),
        ),
      ),
    );
  }

  Form _buildTextForm() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: AppTexts.title,
              ),
              validator: (String? value){
                if(value == null || value.isEmpty){
                  return AppTexts.titleError;
                }
                return null;
              },
            ),
            gap,
            TextFormField(
              maxLines: 8,
              controller: _descriptionController,
              decoration: const InputDecoration(
                hintText: AppTexts.description,
              ),
              validator: (String? value){
                if(value == null || value.isEmpty){
                  return AppTexts.description;
                }
                return null;
              },
            ),
            gap,
            ElevatedButton(onPressed: (){},
                child: const Text(AppTexts.continueT)),
          ],
        ));
  }
  //dispose
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}

