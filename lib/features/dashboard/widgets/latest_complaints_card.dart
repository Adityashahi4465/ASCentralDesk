import 'package:flutter/material.dart';

import '../../../core/utils/color_utility.dart';

import '../../../theme/theme.dart';

class LatestComplaintsCard extends StatelessWidget {
  const LatestComplaintsCard({
    super.key,
    required this.chipLabels,
  });

  final List<String> chipLabels;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: AppColors.white,
        // boxShadow: AppColors.carouselSliderShadow,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'A/C Not Available',
                    style: AppTextStyle.textSemiBold.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.thumb_up,
                        color: AppColors.red,
                        size: 24,
                      ),
                      Text(
                        '  5 votes',
                        style: AppTextStyle.textSemiBold,
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                'Nov 20, 2020 - Dec 4, 2020',
                style: AppTextStyle.textMedium.copyWith(
                  color: AppColors.subTitleColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Wrap(
            spacing: 6,
            children: chipLabels.map((label) {
              Color randomColor = getRandomColor();
              return Chip(
                backgroundColor: randomColor,
                label: Text(
                  label,
                  style: AppTextStyle.textRegular.copyWith(
                    color: AppColors.white,
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
