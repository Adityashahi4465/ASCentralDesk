import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPreferences;

class Responsive {
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 800; // mobile
  }

  static bool isBigScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 800; // web
  }
}
