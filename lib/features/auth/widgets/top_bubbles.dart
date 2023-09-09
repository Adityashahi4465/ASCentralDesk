
import 'package:flutter/material.dart';

import '../animations/auth_animations.dart';

class TopBubble extends StatelessWidget {
  const TopBubble({
    super.key,
    required this.onBoardingEnterAnimation,
    required this.diameter,
    required this.top,
    required this.right,
    required this.linearGradient,
  });

  final OnBoardingEnterAnimation onBoardingEnterAnimation;
  final double diameter;
  final double top;
  final double right;
  final LinearGradient linearGradient;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: right,
      child: Transform(
        transform: Matrix4.diagonal3Values(
            onBoardingEnterAnimation.scaleTranslation.value,
            onBoardingEnterAnimation.scaleTranslation.value,
            1.0),
        child: Container(
          height: diameter,
          width: diameter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(diameter / 2),
            gradient: linearGradient,
          ),
        ),
      ),
    );
  }
}
