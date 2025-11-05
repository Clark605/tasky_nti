import 'package:flutter/material.dart';
import 'package:tasky_nti/core/theme/app_colors.dart';
import 'package:tasky_nti/core/theme/app_fonts.dart';
import 'package:tasky_nti/feature/onboarding/onboarding_data.dart';
import 'package:tasky_nti/feature/onboarding/widgets/custom_animated_widget.dart';
import 'package:tasky_nti/feature/onboarding/widgets/onboarding_button.dart';
import 'package:tasky_nti/feature/onboarding/widgets/onboarding_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  static const String routeName = '/onboarding';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var controller = PageController();
  final List<OnboardingData> onboardingData = OnboardingData.dataOnBoarding();
  int index = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 100),
            SizedBox(
              height: 325,
              child: PageView.builder(
                controller: controller,
                itemCount: onboardingData.length,
                onPageChanged: (value) => setState(() {
                  index = value;
                }),
                itemBuilder: (context, index) {
                  return CustomAnimatedWidget(
                    delay: index,
                    index: index,
                    child: Image.asset(
                      onboardingData[index].image,
                      fit: BoxFit.fill,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 24),
            OnboardingIndicator(
              controller: controller,
              itemCount: onboardingData.length,
            ),
            SizedBox(height: 50),
            CustomAnimatedWidget(
              key: ValueKey(index),
              delay: (index + 1) * 200,
              index: index,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    Text(onboardingData[index].title, style: AppFonts.title),
                    SizedBox(height: 24),
                    Text(
                      onboardingData[index].subtitle,
                      style: AppFonts.onBoardingSubtitle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: OnboardingButton(index: index, controller: controller),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
