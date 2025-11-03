import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:tasky_nti/core/constants/app_constants.dart';
import 'package:tasky_nti/core/theming/app_colors.dart';
import 'package:tasky_nti/feature/onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, OnboardingScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInLeft(child: Image.asset(AppConstants.taskSplashIcon)),
            BounceInUp(
              delay: Duration(milliseconds: 500),
              child: Align(
                alignment: AlignmentGeometry.xy(0.0, 0.02),
                child: Image.asset(AppConstants.yIcon),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
