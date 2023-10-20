import 'package:flutter/material.dart';

import '../core/utils/color_utility.dart';

class AppColors {
  /// **************    Gradients   *******************
  static LinearGradient roundedButtonGradient = LinearGradient(
    begin: FractionalOffset.bottomLeft,
    end: FractionalOffset.topRight,
    colors: <Color>[
      Color(
        getColorHexFromStr("#FE685F"),
      ),
      Color(
        getColorHexFromStr("#FB578B"),
      ),
    ],
  );
  static LinearGradient orangeGradient = LinearGradient(
    begin: FractionalOffset.topLeft,
    end: FractionalOffset.topRight,
    colors: <Color>[
      Color(
        getColorHexFromStr("#fe8c00"),
      ),
      Color(
        getColorHexFromStr("#f83600"),
      ),
    ],
  );
  static LinearGradient blueGradient = const LinearGradient(
    begin: FractionalOffset.bottomLeft,
    end: FractionalOffset.topRight,
    colors: [
      Color.fromARGB(255, 68, 153, 237),
      Color(0xFF418FDE),
      Color.fromARGB(255, 47, 67, 141),
    ],
    // stops: [0.0, 1.0],
  );

  static const LinearGradient roundedButtonDisabledGradient = LinearGradient(
    begin: FractionalOffset.bottomLeft,
    end: FractionalOffset.topRight,
    colors: <Color>[
      Color.fromARGB(255, 214, 202, 202),
      Color.fromARGB(255, 158, 145, 145),
    ],
  );

  /// **************   Box Shadows   *******************

  static const List<BoxShadow> carouselSliderShadow = [
    BoxShadow(
      color: lightShadowColor,
      blurRadius: 32.0,
      spreadRadius: 0.5,
      offset: Offset(1.0, 2.0), // shadow direction: bottom right
    ),
  ];

  /// **************   General Colors   *******************

  static const Color white = Colors.white;
  static const Color black = Color.fromARGB(255, 48, 48, 48);
  static Color lightWhite = Colors.white.withOpacity(
    0.7,
  );
  static const Color green = Color.fromARGB(255, 78, 193, 82);
  static const Color red = Colors.red;
  static const Color pinkAccent = Colors.pinkAccent;

  /// **************   Specific Colors   *******************

  static const Color primary = Colors.pinkAccent;
  static const Color primaryDark = Color.fromARGB(255, 238, 72, 50);
  static const Color splashColor = Color.fromARGB(255, 253, 107, 156);

  // Disabled Color
  static const Color mDisabledColor = Color.fromARGB(175, 162, 162, 162);

  static const Color scaffoldBackgroundColor =
      Color.fromARGB(255, 245, 250, 255);
  static const Color subTitleColor = Color.fromARGB(255, 170, 168, 168);
  static const Color lightShadowColor = Color.fromARGB(255, 215, 215, 215);
}
