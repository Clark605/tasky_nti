import 'package:flutter/material.dart';
import 'package:tasky_nti/core/constants/app_constants.dart';
import 'package:tasky_nti/core/theme/app_fonts.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 14,
        children: [
          const SizedBox(height: 30),
          Image.asset(AppConstants.homeIcon, scale: 2),
          const Text(
            'What do you want to do today?',
            style: AppFonts.homeTitle,
            textAlign: TextAlign.center,
          ),
          const Text(
            'Tap + to add your tasks',
            style: AppFonts.onBoardingSubtitle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
