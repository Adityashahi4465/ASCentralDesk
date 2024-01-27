import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class LikeButton extends StatelessWidget {
  final Color color;
  final String likes;
  const LikeButton({
    super.key,
    required this.color,
    required this.likes,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.thumb_up,
          color: color,
          size: 24,
        ),
        Text(
          '  $likes likes',
          style: AppTextStyle.textSemiBold,
        ),
      ],
    );
  }
}
