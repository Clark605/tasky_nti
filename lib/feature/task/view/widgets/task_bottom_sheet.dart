import 'package:flutter/material.dart';
import 'package:tasky_nti/core/constants/app_constants.dart';
import 'package:tasky_nti/core/utils/validator.dart';
import 'package:tasky_nti/core/widgets/app_text_form_field.dart';
import 'package:tasky_nti/feature/task/view/widgets/task_priority_picker.dart';

class TaskBottomSheet extends StatelessWidget {
  const TaskBottomSheet({super.key});

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
          Text(
            'Add Task',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          AppTextFormField(
            hintText: 'Do math homework',
            controller: TextEditingController(),
            validator: Validator.validateName,
          ),
          AppTextFormField(
            hintText: 'Descrption',
            controller: TextEditingController(),
            validator: Validator.validateName,
          ),
          Row(
            children: [
              InkWell(
                customBorder: CircleBorder(),
                onTap: () => showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                ),
                child: Image.asset(AppConstants.timerIcon, scale: 2),
              ),
              SizedBox(width: 10),
              InkWell(
                onTap: () {
                  TaskPriorityPicker();
                },
                child: Image.asset(AppConstants.flagIcon, scale: 2),
              ),
              Spacer(),
              InkWell(
                onTap: () {},
                child: Image.asset(AppConstants.sendIcon, scale: 2),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
