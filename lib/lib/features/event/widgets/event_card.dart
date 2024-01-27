import 'package:as_central_desk/routes/route_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_constant.dart';
import '../../../core/common/face_pile.dart';
import '../../../models/event.dart';
import '../../../theme/theme.dart';

class EventCard extends StatelessWidget {
  final Event event;
  const EventCard({
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
          width: double.maxFinite,
          height: 150,
          decoration: BoxDecoration(
            color: AppColors.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: AppColors.lightShadowColor,
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    child: event.eventImages.isEmpty
                        ? Image.asset(
                            IMAGE_PATH_DEFAULT_EVENT_THUMBNAIL, // Replace with your image URL
                            height: 150, // Set your desired height
                            width: 130,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            event.eventImages
                                .first, // Replace with your image URL
                            height: 150, // Set your desired height
                            width: 130,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: AppColors.yellow,
                            size: 18,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            (event.feedback.length % 50).toString(),
                            style: AppTextStyle.displayRegular.copyWith(
                              color: AppColors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title,
                        style: AppTextStyle.displayBold.copyWith(
                          fontSize: 16,
                          color: AppColors.black,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        event.location,
                        style: AppTextStyle.displaySemiBold.copyWith(
                          fontSize: 14,
                          color: AppColors.subTitleColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DateFormat(
                          'd MMM yyyy',
                        ).format(
                          event.startDate,
                        ),
                        style: AppTextStyle.textSemiBold.copyWith(
                          color: AppColors.black,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            event.prize > 0
                                ? '${event.prize.toString()} rs'
                                : 'FREE',
                            style: AppTextStyle.textSemiBold.copyWith(
                              color: AppColors.green,
                            ),
                          ),
                          const SizedBox(
                            width: 18,
                          ),
                          const FacePile(
                            profileImages: ['', '', ''],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
