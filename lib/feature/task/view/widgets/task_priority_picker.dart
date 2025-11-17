import 'package:flutter/material.dart';
import 'package:tasky_nti/core/constants/app_constants.dart';
import 'package:tasky_nti/core/theme/app_colors.dart';

class TaskPriorityPicker extends StatefulWidget {
  const TaskPriorityPicker({super.key});

  @override
  State<TaskPriorityPicker> createState() => _TaskPriorityPickerState();
}

class _TaskPriorityPickerState extends State<TaskPriorityPicker> {
  List<int> priorityLevels = List.generate(10, (index) => index + 1);
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(4),
      ),
      titlePadding: EdgeInsets.all(16),
      contentPadding: EdgeInsets.all(16),
      actionsPadding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
      insetPadding: EdgeInsets.symmetric(horizontal: 24),
      title: Column(
        children: [
          Text(
            'Task Priority',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Divider(),
        ],
      ),
      content: Wrap(
        alignment: WrapAlignment.start,
        children: priorityLevels
            .map(
              (index) => _PriorityOption(
                index: index,
                isSelected: selectedIndex == index,
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
            )
            .toList(),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Close',
                  style: TextStyle(color: AppColors.primary),
                ),
              ),
            ),
            Expanded(
              child: MaterialButton(
                height: 50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                onPressed: () {},
                color: AppColors.primary,
                child: Text('Save', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PriorityOption extends StatelessWidget {
  final int index;
  final VoidCallback? onTap;
  final bool isSelected;

  const _PriorityOption({
    super.key,
    required this.index,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: !isSelected ? Colors.grey : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(4),
          color: isSelected ? AppColors.primary : null,
        ),
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
        margin: EdgeInsets.only(left: 8, right: 8, bottom: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppConstants.flagIcon,
              scale: 2,
              color: isSelected ? Colors.white : null,
            ),
            Text(
              index.toString(),
              style: TextStyle(color: isSelected ? Colors.white : null),
            ),
          ],
        ),
      ),
    );
  }
}
