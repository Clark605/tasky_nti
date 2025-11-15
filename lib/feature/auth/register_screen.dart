import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasky_nti/core/theme/app_colors.dart';
import 'package:tasky_nti/core/theme/app_fonts.dart';
import 'package:tasky_nti/core/utils/validator.dart';
import 'package:tasky_nti/core/widgets/app_button.dart';
import 'package:tasky_nti/core/widgets/app_text_form_field.dart';
import 'package:tasky_nti/feature/auth/widgets/signing_nav.dart';
import 'package:tasky_nti/feature/home/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController emailController;
  late TextEditingController usernameController;
  late TextEditingController pswdController;
  late TextEditingController confirmPswdController;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    usernameController = TextEditingController();
    pswdController = TextEditingController();
    confirmPswdController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    pswdController.dispose();
    confirmPswdController.dispose();
    super.dispose();
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
                  const SizedBox(height: 90),
                  const Text('Register', style: AppFonts.title),
                  const SizedBox(height: 24),
                  const Text('Username', style: AppFonts.labelText),
                  const SizedBox(height: 5),
                  AppTextFormField(
                    controller: usernameController,
                    validator: Validator.validateName,
                    hintText: 'Username',
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 24),
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
                  const SizedBox(height: 24),
                  const Text('Confirm Password', style: AppFonts.labelText),
                  const SizedBox(height: 5),
                  AppTextFormField(
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
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CircularProgressIndicator();
                          },
                        );
                        await register(
                              email: emailController.text,
                              password: pswdController.text,
                            )
                            .then((_) {
                              Navigator.canPop(context);
                              usernameController.dispose();
                              emailController.dispose();
                              pswdController.dispose();
                              confirmPswdController.dispose();
                              Navigator.canPop(context);
                              // Perform registration action
                              Navigator.pushReplacementNamed(
                                context,
                                HomeScreen.routeName,
                              );
                            })
                            .catchError((error) {
                              Navigator.canPop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Registration failed: $error'),
                                ),
                              );
                            });
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

  Future<void> register({
    required String email,
    required String password,
  }) async {
    // Implement registration logic here
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      debugPrint('Registration failed: $e');
    }
  }
}
