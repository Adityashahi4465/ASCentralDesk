import 'package:flutter/material.dart';

import '../../../core/utils/color_utility.dart';
import '../animations/auth_animations.dart';

class SocialMediaAppButton extends StatelessWidget {
  const SocialMediaAppButton({
    super.key,
    required this.onBoardingEnterAnimation,
    required this.context,
    required this.color,
    required this.image,
    required this.size,
    required this.animatedValue,
  });

  final OnBoardingEnterAnimation onBoardingEnterAnimation;
  final BuildContext context;
  final String color;
  final String image;
  final double size;
  final double animatedValue;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: onBoardingEnterAnimation.fadeTranslation,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.translationValues(
            animatedValue * MediaQuery.of(context).size.height, 0, 0.0),
        child: Container(
          height: size,
          width: size,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(25),
            color: Color(
              getColorHexFromStr(color),
            ),
          ),
          child: Text(''),
        ),
      ),
    );
  }
}
