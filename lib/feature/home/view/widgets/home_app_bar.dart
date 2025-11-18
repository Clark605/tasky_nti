import 'package:flutter/material.dart';
import 'package:tasky_nti/core/constants/app_constants.dart';
import 'package:tasky_nti/core/theme/app_colors.dart';
import 'package:tasky_nti/core/theme/app_fonts.dart';
import 'package:tasky_nti/feature/auth/data/firebase/fb_auth.dart';
import 'package:tasky_nti/feature/onboarding/onboarding_screen.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      leading: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Image.asset(AppConstants.appLogo, scale: 2),
      ),
      leadingWidth: 100,
      actions: [
        TextButton(
          onPressed: () async {
            await FbAuth.logout();
            Navigator.pushReplacementNamed(context, OnboardingScreen.routeName);
          },
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
    );
  }
}
