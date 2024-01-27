import 'package:as_central_desk/theme/app_text_style.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class TextInputFieldWithToolTip extends StatelessWidget {
  final TextEditingController? controller;
  final String toolTipMessage;
  final String tipText;
  final String hintText;
  final String? suffixText;
  final int maxLines;
  final int maxLength;
  final bool isDisabled;
  final Function(String?)? onChanged;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const TextInputFieldWithToolTip({
    super.key,
    required this.toolTipMessage,
    required this.tipText,
    required this.hintText,
    required this.validator,
    this.controller,
    required this.maxLines,
    this.isDisabled = false,
    this.keyboardType = TextInputType.name,
    this.suffixText,
    this.maxLength = 100,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              tipText,
              style: AppTextStyle.textRegular.copyWith(),
            ),
            const SizedBox(
              width: 10,
            ),
            Tooltip(
              message: toolTipMessage,
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
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          onChanged: onChanged,
          maxLength: maxLength,
          keyboardType: keyboardType,
          enabled: !isDisabled,
          readOnly: isDisabled,
          maxLines: maxLines,
          controller: controller,
          style: const TextStyle(color: Colors.black87, fontSize: 16),
          decoration: InputDecoration(
            suffixText: suffixText,
            suffixStyle: AppTextStyle.textRegular.copyWith(
              fontSize: 14,
              color: AppColors.mDisabledColor,
            ),
            hintStyle: AppTextStyle.textRegular.copyWith(
              color: Colors.black54,
              fontSize: 14,
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.5,
                color: AppColors.secondary,
              ),
            ),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.5,
                color: AppColors.mDisabledColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                width: 1.5,
                color: AppColors.primary,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                width: 1,
                color: AppColors.red,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                width: 1.5,
                color: Color.fromARGB(222, 230, 6, 6),
              ),
            ),
            hintText: hintText,
          ),
          validator: validator,
        ),
      ],
    );
  }
}
