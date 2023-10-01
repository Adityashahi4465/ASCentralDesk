import 'package:as_central_desk/theme/theme.dart';
import 'package:flutter/material.dart';

class FacePile extends StatelessWidget {
  final List<String> profileImages;

  const FacePile({super.key, required this.profileImages});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(
            profileImages.length,
            (index) {
              return Align(
                widthFactor: 0.7,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.lightShadowColor,
                  child: CircleAvatar(
                    radius: 16.0,
                    backgroundImage: NetworkImage(profileImages[index]),
                  ),
                ),
              );
            },
          ) +
          [
            Align(
              widthFactor: 0.8,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.lightWhite,
                child: Text(
                  '50+',
                  style: AppTextStyle.textMedium.copyWith(
                    color: AppColors.black,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
    );
  }
}
