
import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class FormInputHeading extends StatelessWidget {
  final String tipMessage;
  final String heading;
  const FormInputHeading({
    super.key,
    required this.tipMessage,
    required this.heading,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          heading,
          style: AppTextStyle.textRegular.copyWith(),
        ),
        const SizedBox(
          width: 10,
        ),
        Tooltip(
          message: tipMessage,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.lightShadowColor,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: Colors.grey.shade600,
              ),
            ),
            child: const Icon(
              Icons.question_mark,
              size: 14,
              color: AppColors.secondary,
            ),
          ),
        ),
      ],
    );
  }
}