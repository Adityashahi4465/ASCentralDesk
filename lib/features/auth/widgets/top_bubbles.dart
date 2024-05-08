
import 'package:flutter/material.dart';

import '../animations/auth_animations.dart';


class TopBubble extends StatelessWidget {
  const TopBubble({
    Key? key,
    this.onBoardingEnterAnimation,
    this.diameter,
    this.top,
    this.right,
    this.linearGradient,
  }) : super(key: key);

  final OnBoardingEnterAnimation? onBoardingEnterAnimation;
  final double? diameter;
  final double? top;
  final double? right;
  final LinearGradient? linearGradient;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top ?? 0.0,
      right: right ?? 0.0,
      child: Transform(
        transform: Matrix4.diagonal3Values(
            onBoardingEnterAnimation?.scaleTranslation?.value ?? 1.0,
            onBoardingEnterAnimation?.scaleTranslation?.value ?? 1.0,
            1.0),
        child: Container(
          height: diameter ?? 0.0,
          width: diameter ?? 0.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(diameter! / 2),
            gradient: linearGradient,
          ),
        ),
      ),
    );
  }
}
