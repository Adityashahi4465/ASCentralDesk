import 'package:e_complaint_box/global/global.dart';
import 'package:e_complaint_box/screens/splash.dart';
import 'package:e_complaint_box/services/connectivity_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
          child: const SplashScreen(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CMS - Campus Management System',
        theme: ThemeData.dark().copyWith(
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.white,
            primaryColor: const Color.fromRGBO(21, 30, 61, 1)),
        home: const SplashScreen(), // user is not already_logged-In
      ),
    );
  }
}
