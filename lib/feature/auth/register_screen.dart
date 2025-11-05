import 'package:flutter/material.dart';
import 'package:tasky_nti/core/theme/app_colors.dart';
import 'package:tasky_nti/core/theme/app_fonts.dart';
import 'package:tasky_nti/core/utils/validator.dart';
import 'package:tasky_nti/core/widgets/app_button.dart';
import 'package:tasky_nti/core/widgets/app_text_form_field.dart';
import 'package:tasky_nti/feature/auth/widgets/sigin_nav.dart';
import 'package:tasky_nti/feature/home/home_screen.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  static const String routeName = '/register';

  var emailController = TextEditingController();
  var usernameController = TextEditingController();
  var pswdController = TextEditingController();
  var confirmPswdController = TextEditingController();
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
                  const SizedBox(height: 90),
                  const Text('Register', style: AppFonts.title),
                  const SizedBox(height: 24),
                  const Text('Username', style: AppFonts.labelText),
                  const SizedBox(height: 5),
                  AppTextFormFeild(
                    controller: usernameController,
                    validator: Validator.validateName,
                    hintText: 'Username',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 24),
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
                  const SizedBox(height: 24),
                  const Text('Confirm Password', style: AppFonts.labelText),
                  const SizedBox(height: 5),
                  AppTextFormFeild(
                    controller: confirmPswdController,
                    validator: (val) => Validator.validateConfirmPassword(
                      val,
                      pswdController.text,
                    ),
                    hintText: 'Confirm Password',
                    isPassword: true,
                    obscureText: true,
                  ),
                  const SizedBox(height: 72),
                  AppButton(
                    text: 'Register',
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
        title: "Already have an account?",
        subTitle: 'Log in',
        onTap: () => Navigator.pop(context),
      ),
    );
  }
}
