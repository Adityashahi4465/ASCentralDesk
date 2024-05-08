import 'package:flutter/material.dart';

import '../../../core/common/face_pile.dart';
import '../../../theme/theme.dart';

class LatestEventsCard extends StatelessWidget {
  const LatestEventsCard({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.5,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: AppColors.blueGradient,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              const Icon(
                Icons.money,
                color: AppColors.green,
              ),
              Text(
                '  Paid - 1000rs',
                style: AppTextStyle.textMedium.copyWith(
                  color: AppColors.white,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            '5 Nov, 2003 - 10:00',
            style: AppTextStyle.textLight.copyWith(
              color: AppColors.lightWhite,
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Dance',
            style: AppTextStyle.displaySemiBold.copyWith(
              color: AppColors.white,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'A Dance competition between students',
            style: AppTextStyle.textLight.copyWith(
              color: AppColors.lightWhite,
              fontSize: 12,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on,
                color: AppColors.red,
              ),
              Flexible(
                child: Text(
                  ' DSEU Dwarka Campus',
                  style: AppTextStyle.textLight.copyWith(
                    color: AppColors.lightWhite,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            '500+ participants',
            style: AppTextStyle.textLight.copyWith(
              color: AppColors.lightWhite,
              fontSize: 12,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 8,
          ),
          const FacePile(
            profileImages: [
              'https://i.stack.imgur.com/knlmd.jpg',
              'https://i.stack.imgur.com/dBagH.png',
              'https://www.tutorialspoint.com/opencv/images/face_detection_using_camera.jpg',
            ],
          ),
        ],
      ),
    );
  }
}
