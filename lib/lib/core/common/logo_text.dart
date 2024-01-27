import 'package:as_central_desk/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class LogoText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Text(
      "ASCentralDesk",
      style: AppTextStyle.displayBold.copyWith(
        color: Colors.black.withOpacity(0.6),
        fontSize: 26,
      ),
    );
  }
}
