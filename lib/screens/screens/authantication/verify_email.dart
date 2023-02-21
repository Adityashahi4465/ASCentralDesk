import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../global_widgets/background-image.dart';
import '../../palatte.dart';
import '../splash.dart';
import 'students_login_Screen.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    // user needs to be created first

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (!isEmailVerified) {
      sendVerificationEmail();

      // Timer to check if email is verified or not
      timer = Timer.periodic(
        const Duration(seconds: 10),
        (_) => checkEmailVerified(),
      );
    }
  }

  Future checkEmailVerified() async {
    // call after email verification!

    await FirebaseAuth.instance.currentUser?.reload();
    setState(() {
      // due to this when email is verified we wil redirected to home page
      isEmailVerified = FirebaseAuth.instance.currentUser!
          .emailVerified; //return's true if email is verified
    });
    if (isEmailVerified) {
      timer?.cancel();
      Fluttertoast.showToast(
          msg: 'Your Email Successfully Verified.\nNow you can user our app');
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user?.sendEmailVerification();

      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(const Duration(seconds: 10));
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const SplashScreen() // Email is verified sand user to splash screen
      : MaterialApp(
          title: 'Verify Email',
          home: Stack(
            children: [
              const BackgroundImage(),
              Scaffold(
                backgroundColor: Colors.transparent,
                body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: [
                        const SizedBox(
                          height: 150,
                          child: Center(
                            child: Text(
                              'E-ASComplaint',
                              style: kHeading,
                            ),
                          ),
                        ),
                        Image.asset(
                          "assets/images/splash.png",
                          height: 200,
                          width: 200,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'A verification email has been sent to your email.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.white70),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'please Check your spam folder',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                          ),
                          icon: const Icon(
                            Icons.email,
                            size: 32,
                          ),
                          label: const Text(
                            'Resent Email',
                            style: TextStyle(fontSize: 24),
                          ),
                          onPressed:
                              canResendEmail ? sendVerificationEmail : null,
                        ),
                        TextButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(fontSize: 24),
                            ))
                      ],
                    )),
              )
            ],
          ),
        );
}
