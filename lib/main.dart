import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tasky_nti/feature/auth/view/login_screen.dart';
import 'package:tasky_nti/feature/auth/view/register_screen.dart';
import 'package:tasky_nti/feature/home/home_screen.dart';
import 'package:tasky_nti/feature/onboarding/onboarding_screen.dart';
import 'package:tasky_nti/feature/splash/splash.dart';
import 'package:tasky_nti/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasky NTI',
      initialRoute: HomeScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        OnboardingScreen.routeName: (context) => const OnboardingScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
    );
  }
}
