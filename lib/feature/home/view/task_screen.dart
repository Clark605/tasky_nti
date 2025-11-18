import 'package:flutter/material.dart';
import 'package:tasky_nti/core/constants/app_constants.dart';
import 'package:tasky_nti/core/firebase/fb_result.dart';
import 'package:tasky_nti/core/theme/app_colors.dart';
import 'package:tasky_nti/core/theme/app_fonts.dart';
import 'package:tasky_nti/core/utils/formatter.dart';
import 'package:tasky_nti/core/widgets/app_button.dart';
import 'package:tasky_nti/core/widgets/app_dialogs.dart';
import 'package:tasky_nti/feature/home/data/firebase/fb_task.dart';
import 'package:tasky_nti/feature/home/data/model/task_model.dart';
import 'package:tasky_nti/feature/home/view/widgets/task_priority_picker.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});
  static const String routeName = '/task_screen';

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: BackButton(color: AppColors.black),
        title: Text("Task Details", style: AppFonts.homeTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 28,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Transform.scale(
                  scale: 1.2,
                  child: Checkbox(
                    value: taskModel.isCompleted,
                    onChanged: (onChanged) {
                      setState(() {
                        taskModel.isCompleted = onChanged ?? false;
                      });
                    },
                  ),
                ),
                Text(taskModel.title ?? '', style: AppFonts.title),
              ],
            ),
            Text(taskModel.description ?? '', style: AppFonts.labelText),
            Row(
              spacing: 8,
              children: [
                Image.asset(AppConstants.timerIcon, scale: 2),
                Text('Task time:', style: AppFonts.labelText),
                Spacer(),
                TextButton(
                  onPressed: () async {
                    taskModel.date =
                        await showDatePicker(
                          context: context,
                          initialDate: taskModel.date!,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 30)),
                        ) ??
                        taskModel.date;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      Formatter.formattedDate(taskModel.date!),
                      style: AppFonts.cardSubtitle,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              spacing: 8,
              children: [
                Image.asset(AppConstants.flagIcon, scale: 2),
                Text('Task Priority:', style: AppFonts.labelText),
                Spacer(),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => TaskPriorityPicker(
                        onPrioritySelected: (priority) {
                          taskModel.priority = priority;
                          setState(() {});
                        },
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      taskModel.priority.toString(),
                      style: AppFonts.cardSubtitle,
                    ),
                  ),
                ),
              ],
            ),
            InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onTap: () async {
                AppDialogs.showLoadingDialog(context);
                await onDelete(context);

                // Show error message
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 1,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 8,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(AppConstants.trashIcon, scale: 2),
                    Text(
                      'Detele Task',
                      style: AppFonts.labelText.copyWith(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            AppButton(
              text: "Update Task",
              onPressed: () async {
                AppDialogs.showLoadingDialog(context);
                await onUpdate(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  late TaskModel taskModel;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      taskModel = ModalRoute.of(context)!.settings.arguments as TaskModel;
      setState(() {});
    });
  }

  Future<void> onUpdate(BuildContext context) async {
    final result = await FbTask.updateTask(taskModel);
    switch (result) {
      case Success<void>():
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        AppDialogs.showSuccessDialog(
          context,
          message: 'Task Updated Successfully!',
        );
      case Failure<void>():
        Navigator.of(context).pop();
        AppDialogs.showErrorDialog(context, message: result.errorMsg);
    }
  }

  Future<void> onDelete(BuildContext context) async {
    final result = await FbTask.deleteTask(taskModel.id!);
    switch (result) {
      case Success<void>():
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        AppDialogs.showSuccessDialog(
          context,
          message: 'Task deleted Successfully!',
        );
      case Failure<void>():
        Navigator.of(context).pop();
        AppDialogs.showErrorDialog(context, message: result.errorMsg);
    }
  }
}
