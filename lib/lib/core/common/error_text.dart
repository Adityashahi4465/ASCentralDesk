import 'package:as_central_desk/theme/theme.dart';
import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String error;
  const ErrorText({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Text(
      error,
      style: AppTextStyle.textBold.copyWith(color: AppColors.black),
    );
  }
}
