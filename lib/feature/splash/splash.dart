import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasky_nti/core/constants/app_constants.dart';
import 'package:tasky_nti/core/theme/app_colors.dart';
import 'package:tasky_nti/feature/home/view/home_screen.dart';
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

    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted && FirebaseAuth.instance.currentUser == null) {
        Navigator.pushReplacementNamed(context, OnboardingScreen.routeName);
      } else {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      }
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
            FadeInLeft(
              from: 300,
              duration: const Duration(milliseconds: 800),
              child: Image.asset(AppConstants.taskSplashIcon),
            ),
            BounceInUp(
              delay: const Duration(milliseconds: 800),
              child: Align(
                alignment: const Alignment(0.0, 0.02),
                child: Image.asset(AppConstants.yIcon),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
