import 'package:flutter/material.dart';
import 'package:tasky_nti/core/theme/app_colors.dart';

abstract class AppFonts {
  static const TextStyle onBoardingTitle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.titleText,
  );

  static const TextStyle onBoardingSubtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.subtitleText,
  );
  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static const TextStyle labelText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.titleText,
  );

  static const TextStyle hintText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
    overflow: TextOverflow.ellipsis,
  );
}
