import 'package:flutter/material.dart';
import 'package:tasky_nti/core/firebase/fb_result.dart';
import 'package:tasky_nti/core/theme/app_colors.dart';
import 'package:tasky_nti/core/theme/app_fonts.dart';
import 'package:tasky_nti/core/utils/validator.dart';
import 'package:tasky_nti/core/widgets/app_button.dart';
import 'package:tasky_nti/core/widgets/app_dialogs.dart';
import 'package:tasky_nti/core/widgets/app_text_form_field.dart';
import 'package:tasky_nti/feature/auth/data/firebase/fb_auth.dart';
import 'package:tasky_nti/feature/auth/data/model/user_model.dart';
import 'package:tasky_nti/feature/auth/view/widgets/signing_nav.dart';

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
                        AppDialogs.showLoadingDialog(context);
                        await register(
                          user: UserModel(
                            email: emailController.text,
                            userName: usernameController.text,
                          ),
                          password: pswdController.text,
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

  Future<void> register({
    required UserModel user,
    required String password,
  }) async {
    final result = await FbAuth.register(user, password);
    switch (result) {
      case Succces<void>():
        Navigator.pop(context);
        Navigator.pop(context);
      case Faluire():
        Navigator.pop(context);
        AppDialogs.showErrorDialog(context, message: result.errorMsg);
    }
  }
}
