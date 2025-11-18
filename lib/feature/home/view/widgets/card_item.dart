import 'package:flutter/material.dart';
import 'package:tasky_nti/core/constants/app_constants.dart';
import 'package:tasky_nti/core/theme/app_colors.dart';
import 'package:tasky_nti/core/theme/app_fonts.dart';
import 'package:tasky_nti/core/utils/formatter.dart';

class CardItem extends StatefulWidget {
  const CardItem({
    super.key,
    required this.title,
    required this.date,
    required this.priority,
  });
  final String title;
  final DateTime date;
  final int priority;

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  bool isCompleted = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 16, top: 16, bottom: 16),
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
                setState(() {
                  isCompleted = value!;
                });
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
                Text(widget.title, style: AppFonts.cardTitle),
                Text(
                  Formatter.formattedDate(widget.date),
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
            padding: EdgeInsets.all(6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(AppConstants.flagIcon, scale: 2),
                Text(' ${widget.priority} '),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
