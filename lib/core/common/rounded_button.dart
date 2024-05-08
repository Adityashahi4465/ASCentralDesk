import 'package:as_central_desk/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final LinearGradient linearGradient;

  const RoundedButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.linearGradient,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
      child: Container(
        height: 48.0,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: linearGradient,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
              onTap: onPressed,
              child: Center(
                child: Text(
                  text,
                  style: AppTextStyle.displayBold.copyWith(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
