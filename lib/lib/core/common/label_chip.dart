import 'package:flutter/material.dart';

import '../../theme/app_text_style.dart';

class LabelChip extends StatelessWidget {
  final String label;
  final Color color;
  final IconData? icon;
  final Color? backgroundColor;

  const LabelChip({
    super.key,
    required this.label,
    required this.color,
    required this.icon,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      side: BorderSide.none,
      backgroundColor: backgroundColor ?? color.withOpacity(0.1),
      label: Padding(
        padding: const EdgeInsets.all(1.0),
        child: SizedBox(
          child: icon != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      icon,
                      color: color,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      label,
                      style: AppTextStyle.displaySemiBold.copyWith(
                        color: color,
                      ),
                    ),
                  ],
                )
              : Text(
                  label,
                  style: AppTextStyle.displaySemiBold.copyWith(
                    color: color,
                  ),
                ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
