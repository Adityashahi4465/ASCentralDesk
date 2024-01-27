import 'package:as_central_desk/theme/theme.dart';
import 'package:flutter/material.dart';

import '../../constants/app_constant.dart';

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
                  radius: 14,
                  backgroundColor: AppColors.primary,
                  child: CircleAvatar(
                    radius: 12.0,
                    backgroundImage: (profileImages[index] != "")
                        ? NetworkImage(profileImages[index])
                        : const AssetImage(
                            IMAGE_PATH_DEFAULT_USER_PROFILE_IMAGE,
                          ) as ImageProvider<Object>?,
                  ),
                ),
              );
            },
          ) +
          [
            Align(
              widthFactor: 0.8,
              child: CircleAvatar(
                radius: 16,
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
