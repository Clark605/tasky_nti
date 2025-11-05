import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tasky_nti/core/theme/app_colors.dart';

class OnboardingIndicator extends StatelessWidget {
  const OnboardingIndicator({
    super.key,
    required this.controller,
    required this.itemCount,
  });

  final PageController controller;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: itemCount,
      effect: CustomizableEffect(
        activeDotDecoration: DotDecoration(
          width: 24,
          height: 4,
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(16),
        ),
        dotDecoration: DotDecoration(
          width: 24,
          height: 4,
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
