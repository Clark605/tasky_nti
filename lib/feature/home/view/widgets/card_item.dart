import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tasky_nti/core/constants/app_constants.dart';
import 'package:tasky_nti/core/theme/app_colors.dart';
import 'package:tasky_nti/core/theme/app_fonts.dart';
import 'package:tasky_nti/core/utils/formatter.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.title,
    required this.date,
    required this.priority,
    required this.isCompleted,
    required this.onChanged,
    required this.onTap,
    required this.onDelete,
  });
  final String title;
  final DateTime date;
  final int priority;
  final bool isCompleted;
  final void Function(bool?) onChanged;
  final VoidCallback onTap;
  final void Function(BuildContext) onDelete;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            onPressed: onDelete,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.only(right: 16, top: 16, bottom: 16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Transform.scale(
                scale: 1.2,
                child: Checkbox(
                  value: isCompleted,
                  onChanged: (value) {
                    onChanged(value);
                  },
                  side: BorderSide(width: 1.5, color: AppColors.primary),
                  activeColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),

              Expanded(
                child: Column(
                  spacing: 6,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppFonts.cardTitle),
                    Text(
                      Formatter.formattedDate(date),
                      style: AppFonts.cardSubtitle,
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.all(6),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(AppConstants.flagIcon, scale: 2),
                    Text(' $priority '),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
