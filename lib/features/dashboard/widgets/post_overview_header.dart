
import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class PostsOverviewHeader extends StatelessWidget {
  final String heading;
  final VoidCallback onPressed;
  const PostsOverviewHeader({
    super.key,
    required this.heading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          heading,
          style: AppTextStyle.displayBold.copyWith(
            fontSize: 24,
            color: AppColors.black,
          ),
        ),
        InkWell(
          onTap: onPressed,
          splashColor: AppColors.pinkAccent,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.white,
            ),
            child: const Icon(
              Icons.keyboard_arrow_right_rounded,
              size: 34,
              color: AppColors.pinkAccent,
              weight: 5.0,
            ),
          ),
        )
      ],
    );
  }
}