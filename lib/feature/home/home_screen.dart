import 'package:flutter/material.dart';
import 'package:tasky_nti/core/constants/app_constants.dart';
import 'package:tasky_nti/core/theme/app_colors.dart';
import 'package:tasky_nti/core/theme/app_fonts.dart';
import 'package:tasky_nti/feature/splash/splash.dart';
import 'package:tasky_nti/feature/task/view/widgets/task_bottom_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Image.asset(AppConstants.appLogo, scale: 2),
        ),
        leadingWidth: 100,
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, SplashScreen.routeName),
            child: Row(
              children: [
                Image.asset(AppConstants.logOutIcon, scale: 2),
                const SizedBox(width: 10),
                Text(
                  'Log out',
                  style: AppFonts.labelText.copyWith(color: Colors.red),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 14,
        children: [
          const SizedBox(height: 80),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => TaskBottomSheet(),
            isScrollControlled: true,
          );
        },
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 32),
      ),
    );
  }
}
