import 'package:flutter/material.dart';
import 'package:tasky_nti/core/theme/app_colors.dart';
import 'package:tasky_nti/core/theme/app_fonts.dart';

class SigningNav extends StatelessWidget {
  const SigningNav({
    super.key,
    required this.title,
    required this.subTitle,
    this.onTap,
  });
  final String title;
  final String subTitle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            text: "$title ",
            style: AppFonts.signNav,
            children: [
              TextSpan(
                text: subTitle,
                style: AppFonts.signNav.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
