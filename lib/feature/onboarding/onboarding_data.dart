import 'package:tasky_nti/core/constants/app_constants.dart';

class OnboardingData {
  final String image;
  final String title;
  final String subtitle;
  OnboardingData({
    required this.image,
    required this.title,
    required this.subtitle,
  });
  static List<OnboardingData> dataOnBoarding() {
    return [
      OnboardingData(
        image: AppConstants.onBoardingImage1,
        title: 'Manage your tasks',
        subtitle:
            'You can easily manage all of your daily tasks in Tasky for free',
      ),
      OnboardingData(
        image: AppConstants.onBoardingImage2,
        title: 'Create daily routine',
        subtitle:
            'In Tasky you can create your personalized routine to stay productive',
      ),
      OnboardingData(
        image: AppConstants.onBoardingImage3,
        title: 'Organize your tasks',
        subtitle:
            'You can organize your daily tasks by adding your tasks into separate categories',
      ),
    ];
  }
}
