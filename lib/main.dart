import 'package:flutter/material.dart';
import 'package:tasky_nti/feature/auth/login_screen.dart';
import 'package:tasky_nti/feature/auth/register_screen.dart';
import 'package:tasky_nti/feature/home/home_screen.dart';
import 'package:tasky_nti/feature/onboarding/onboarding_screen.dart';
import 'package:tasky_nti/feature/splash/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasky NTI',
      initialRoute: LoginScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        OnboardingScreen.routeName: (context) => const OnboardingScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
    );
  }
}
