import 'package:flutter/material.dart';
import 'package:tasky_nti/core/theme/app_colors.dart';
import 'package:tasky_nti/core/theme/app_fonts.dart';
import 'package:tasky_nti/core/widgets/app_button.dart';
import 'package:tasky_nti/core/widgets/app_text_form_field.dart';
import 'package:tasky_nti/feature/auth/widgets/sigin_nav.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  static const String routeName = '/login';

  var emailController = TextEditingController();
  var pswdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                const Text('Login', style: AppFonts.onBoardingTitle),
                const SizedBox(height: 48),
                const Text('Email', style: AppFonts.labelText),
                const SizedBox(height: 5),
                AppTextFormFeild(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 24),
                const Text('Password', style: AppFonts.labelText),
                const SizedBox(height: 5),
                AppTextFormFeild(
                  controller: pswdController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  hintText: 'Password',
                  isPassword: true,
                  obscureText: true,
                ),
                const SizedBox(height: 72),
                AppButton(text: 'Login', onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const SigningNav(
        title: "Don't have an account?",
        subTitle: 'Sign Up',
      ),
    );
  }
}
