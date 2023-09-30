import 'package:flutter/material.dart';

import '../core/utils/color_utility.dart';

class AppColors {
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
  static const LinearGradient roundedButtonDisabledGradient = LinearGradient(
    begin: FractionalOffset.bottomLeft,
    end: FractionalOffset.topRight,
    colors: <Color>[
      Color.fromARGB(255, 214, 202, 202),
      Color.fromARGB(255, 158, 145, 145),
    ],
  );
  static const Color white = Colors.white;
  static Color lightWhite = Colors.white.withOpacity(
    0.7,
  );
  static const Color green = Color.fromARGB(255, 78, 193, 82);
  static const Color red = Colors.red;
}
