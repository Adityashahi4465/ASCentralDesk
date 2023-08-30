import 'package:flutter/material.dart';

class LogoText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Text(
      "LOGO",
      style: textTheme.headline4!.copyWith(color: Colors.black.withOpacity(0.6)),
    );
  }
}
