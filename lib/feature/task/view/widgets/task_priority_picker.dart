import 'package:flutter/material.dart';
import 'package:tasky_nti/core/constants/app_constants.dart';

class TaskPriorityPicker extends StatelessWidget {
  const TaskPriorityPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        children: [
          Text(
            'Task Priority',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Divider(),
          Wrap(children: [PriorityOption(index: 1)]),
        ],
      ),
    );
  }
}

class PriorityOption extends StatelessWidget {
  int index;
  PriorityOption({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Image.asset(AppConstants.flagIcon, scale: 2),
          Text(index.toString()),
        ],
      ),
    );
  }
}
