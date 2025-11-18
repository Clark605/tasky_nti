import 'package:flutter/material.dart';
import 'package:tasky_nti/core/constants/app_constants.dart';
import 'package:tasky_nti/core/firebase/fb_result.dart';
import 'package:tasky_nti/core/theme/app_colors.dart';
import 'package:tasky_nti/core/utils/formatter.dart';
import 'package:tasky_nti/core/widgets/app_dialogs.dart';
import 'package:tasky_nti/core/widgets/app_text_form_field.dart';
import 'package:tasky_nti/feature/home/data/firebase/fb_task.dart';
import 'package:tasky_nti/feature/home/data/model/task_model.dart';
import 'package:tasky_nti/feature/home/view/widgets/task_priority_picker.dart';

class TaskBottomSheet extends StatefulWidget {
  const TaskBottomSheet({super.key});

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 14,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add Task',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ListenableBuilder(
                listenable: taskModel,
                builder: (context, child) {
                  return Row(
                    spacing: 8,
                    children: [
                      if (taskModel.date != null)
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            Formatter.formattedDate(taskModel.date!),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      if (taskModel.priority != null)
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primary),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: EdgeInsets.all(6),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(AppConstants.flagIcon, scale: 2),
                              Text(taskModel.priority.toString()),
                            ],
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
          AppTextFormField(
            hintText: 'Do math homework',
            controller: taskTitleController,
          ),
          AppTextFormField(
            hintText: 'Description',
            controller: taskDescriptionController,
          ),
          Row(
            children: [
              InkWell(
                customBorder: CircleBorder(),
                onTap: () => datePickerOnTap(context),
                child: Image.asset(AppConstants.timerIcon, scale: 2),
              ),
              SizedBox(width: 10),
              InkWell(
                onTap: () => priorityOnTap(context),
                child: Image.asset(AppConstants.flagIcon, scale: 2),
              ),
              Spacer(),
              ListenableBuilder(
                listenable: taskModel,
                builder: (context, child) {
                  final isValid =
                      taskModel.title != null &&
                      taskModel.title!.isNotEmpty &&
                      taskModel.description != null &&
                      taskModel.description!.isNotEmpty &&
                      taskModel.date != null &&
                      taskModel.priority != null;
                  return InkWell(
                    onTap: !isValid
                        ? () {
                            AppDialogs.showErrorDialog(
                              context,
                              message: 'Please fill all fields',
                            );
                          }
                        : () {
                            taskModel.title = taskTitleController.text;
                            taskModel.description =
                                taskDescriptionController.text;
                            AppDialogs.showLoadingDialog(context);
                            sendTaskOnTap(context);
                          },
                    child: Image.asset(
                      AppConstants.sendIcon,
                      scale: 2,
                      color: !isValid ? Colors.grey : AppColors.primary,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> sendTaskOnTap(BuildContext context) async {
    final result = await FbTask.addTask(taskModel);
    switch (result) {
      case Success():
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        AppDialogs.showSuccessDialog(
          context,
          message: 'Task added Successfully!',
        );
      case Failure():
        Navigator.of(context).pop();
        AppDialogs.showErrorDialog(context, message: result.errorMsg);
    }
  }

  Future<dynamic> priorityOnTap(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => TaskPriorityPicker(
        onPrioritySelected: (priority) {
          taskModel.setPriority(priority);
        },
      ),
    );
  }

  Future<void> datePickerOnTap(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
      initialDate: DateTime.now(),
    );
    if (date == null) return;
    taskModel.setDate(date);
  }

  late TextEditingController taskTitleController;
  late TextEditingController taskDescriptionController;

  late TaskModel taskModel;
  @override
  void initState() {
    super.initState();
    taskTitleController = TextEditingController();
    taskDescriptionController = TextEditingController();
    taskModel = TaskModel();
    taskTitleController.addListener(() {
      taskModel.title = taskTitleController.text;
      taskModel.notifyListeners();
    });

    taskDescriptionController.addListener(() {
      taskModel.description = taskDescriptionController.text;
      taskModel.notifyListeners();
    });
  }

  @override
  void dispose() {
    super.dispose();
    taskTitleController.dispose();
    taskDescriptionController.dispose();
    taskModel.dispose();
  }
}
