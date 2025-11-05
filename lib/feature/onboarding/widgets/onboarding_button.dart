import 'package:flutter/material.dart';
import 'package:tasky_nti/core/theme/app_colors.dart';
import 'package:tasky_nti/core/theme/app_fonts.dart';
import 'package:tasky_nti/feature/auth/login_screen.dart';

class OnboardingButton extends StatelessWidget {
  const OnboardingButton({
    super.key,
    required this.index,
    required this.controller,
  });

  final int index;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        if (index < 2) {
          controller.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        } else {
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        }
      },
      height: 50,
      elevation: 0,
      highlightElevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: AppColors.primary,
      child: Text(
        index == 2 ? 'Get Started' : 'Next',
        style: AppFonts.buttonText,
      ),
    );
  }
}
