import 'package:as_central_desk/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../../../core/common/face_pile.dart';
import '../../../models/event.dart';
import '../../../routes/route_utils.dart';
import '../../../theme/theme.dart';

class PopularEventsCard extends StatelessWidget {
  final Event event;
  const PopularEventsCard({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: InkWell(
        onTap: () => Navigation.navigateToEventDetailsScreen(
          context,
          event.id,
        ),
        child: Container(
          width: 200,
          height: 300,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: AppColors.lightShadowColor,
                blurRadius: 10,
                spreadRadius: 1,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Event image

              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: event.eventImages.isEmpty
                        ? Image.asset(
                            IMAGE_PATH_DEFAULT_EVENT_THUMBNAIL, // Replace with your image URL
                            height: 150, // Set your desired height
                            width: double.maxFinite,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            event.eventImages
                                .first, // Replace with your image URL
                            height: 150, // Set your desired height
                            width: double.maxFinite,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.mDisabledColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                        ),
                      ),
                      child: Text(
                        DateFormat(
                          'd MMMM yyyy',
                        ).format(
                          event.startDate,
                        ),
                        style: AppTextStyle.displayRegular.copyWith(
                          color: AppColors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: AppTextStyle.displayBold.copyWith(
                        fontSize: 18,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      event.location,
                      style: AppTextStyle.displaySemiBold.copyWith(
                        fontSize: 14,
                        color: AppColors.subTitleColor,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: (event.feedback.length % 50),
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: AppColors.yellow,
                          ),
                          itemCount: 5,
                          itemSize: 20.0,
                          direction: Axis.horizontal,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          (event.feedback.length % 50).toString(),
                          style: AppTextStyle.textSemiBold.copyWith(
                            color: AppColors.black,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FacePile(
                          profileImages: event.attendees.take(3).toList(),
                        ),
                        Text(
                          event.prize > 0
                              ? '${event.prize.toString()} rs'
                              : 'FREE',
                          style: AppTextStyle.textSemiBold.copyWith(
                            color: AppColors.green,
                          ),
                        ),
                      ],
                    ),

                    // Add more details as needed
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
