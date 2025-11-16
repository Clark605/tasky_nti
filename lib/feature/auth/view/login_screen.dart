import 'package:flutter/material.dart';
import 'package:tasky_nti/core/firebase/fb_result.dart';
import 'package:tasky_nti/core/theme/app_colors.dart';
import 'package:tasky_nti/core/theme/app_fonts.dart';
import 'package:tasky_nti/core/utils/validator.dart';
import 'package:tasky_nti/core/widgets/app_button.dart';
import 'package:tasky_nti/core/widgets/app_dialogs.dart';
import 'package:tasky_nti/core/widgets/app_text_form_field.dart';
import 'package:tasky_nti/feature/auth/data/firebase/fb_auth.dart';
import 'package:tasky_nti/feature/auth/view/register_screen.dart';
import 'package:tasky_nti/feature/auth/view/widgets/signing_nav.dart';
import 'package:tasky_nti/feature/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController pswdController;
  late GlobalKey<FormState> formKey;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    pswdController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    pswdController.dispose();
  }

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
                  AppTextFormField(
                    controller: emailController,
                    validator: Validator.validateEmail,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 24),
                  const Text('Password', style: AppFonts.labelText),
                  const SizedBox(height: 5),
                  AppTextFormField(
                    controller: pswdController,
                    validator: Validator.validatePassword,
                    hintText: 'Password',
                    isPassword: true,
                    obscureText: true,
                  ),
                  const SizedBox(height: 72),
                  AppButton(
                    text: 'Login',
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        // Perform login action
                        await login(
                          email: emailController.text,
                          password: pswdController.text,
                        ).then((_) {});
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

  Future<void> login({required String email, required String password}) async {
    AppDialogs.showLoadingDialog(context);
    final result = await FbAuth.login(email, password);
    Navigator.pop(context);
    switch (result) {
      case Success():
        AppDialogs.showSuccessDialog(
          context,
          message: "Welcome back, ${result.data!.userName}!",
        ).then(
          (_) => Navigator.pushReplacementNamed(context, HomeScreen.routeName),
        );
      case Failure():
        AppDialogs.showErrorDialog(context, message: result.errorMsg);
    }
  }
}
