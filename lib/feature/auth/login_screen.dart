import 'package:flutter/material.dart';
import 'package:tasky_nti/core/theme/app_colors.dart';
import 'package:tasky_nti/core/theme/app_fonts.dart';
import 'package:tasky_nti/core/utils/validator.dart';
import 'package:tasky_nti/core/widgets/app_button.dart';
import 'package:tasky_nti/core/widgets/app_text_form_field.dart';
import 'package:tasky_nti/feature/auth/register_screen.dart';
import 'package:tasky_nti/feature/auth/widgets/sigin_nav.dart';
import 'package:tasky_nti/feature/home/home_screen.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  static const String routeName = '/login';

  var emailController = TextEditingController();
  var pswdController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  const Text('Login', style: AppFonts.title),
                  const SizedBox(height: 48),
                  const Text('Email', style: AppFonts.labelText),
                  const SizedBox(height: 5),
                  AppTextFormFeild(
                    controller: emailController,
                    validator: Validator.validateEmail,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 24),
                  const Text('Password', style: AppFonts.labelText),
                  const SizedBox(height: 5),
                  AppTextFormFeild(
                    controller: pswdController,
                    validator: Validator.validatePassword,
                    hintText: 'Password',
                    isPassword: true,
                    obscureText: true,
                  ),
                  const SizedBox(height: 72),
                  AppButton(
                    text: 'Login',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // Perform login action
                        Navigator.pushReplacementNamed(
                          context,

                          HomeScreen.routeName,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SigningNav(
        title: "Don't have an account?",
        subTitle: 'Sign Up',
        onTap: () => Navigator.pushNamed(context, RegisterScreen.routeName),
      ),
    );
  }
}
