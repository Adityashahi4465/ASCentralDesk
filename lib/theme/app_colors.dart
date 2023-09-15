import 'package:flutter/material.dart';

import '../core/utils/color_utility.dart';

class AppColors {
  static LinearGradient roundedButtonGradient = LinearGradient(
    begin: FractionalOffset.bottomLeft,
    end: FractionalOffset.topRight,
    colors: <Color>[
      Color(getColorHexFromStr("#FE685F")),
      Color(getColorHexFromStr("#FB578B")),
    ],
  );
  static const LinearGradient roundedButtonDisabledGradient = LinearGradient(
    begin: FractionalOffset.bottomLeft,
    end: FractionalOffset.topRight,
    colors: <Color>[
      Color.fromARGB(249, 144, 118, 118),
      Color.fromARGB(255, 210, 198, 198),
    ],
  );
}
