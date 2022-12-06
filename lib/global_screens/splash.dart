import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:e_complaint_box/routes/nevigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/authantication/students_login_Screen.dart';
import '../widgets/students_drawer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset('assets/images/splash.png'),
      curve: Curves.bounceIn,
      nextScreen: (FirebaseAuth.instance.currentUser != null)
          ? User1()
          : const StudentLoginPage(),
      splashTransition: SplashTransition.sizeTransition,
      duration: 300,
      splashIconSize: 220.0,
    );
  }
}
