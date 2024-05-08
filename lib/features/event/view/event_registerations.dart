import 'package:as_central_desk/features/event/controller/event_controller.dart';
import 'package:as_central_desk/features/user/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/app_constant.dart';
import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';
import '../../../routes/route_utils.dart';
import '../../../theme/theme.dart';

class EventRegistrationsScreen extends ConsumerWidget {
  final String eventId;

  const EventRegistrationsScreen({
    Key? key,
    required this.eventId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Event Registrations',
          style: AppTextStyle.displayBlack.copyWith(
            color: AppColors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: AppColors.black,
            size: 30,
          ),
          onPressed: () => Navigation.navigateToBack(context),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: ref.watch(getEventByIdProvider(eventId)).when(
            data: (event) {
              final attendees = event?.attendees;
              if (attendees == null || attendees.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.sentiment_dissatisfied,
                        size: 48,
                        color: AppColors.greyColor,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'No attendees yet.',
                        style: AppTextStyle.textRegular.copyWith(
                          color: AppColors.greyColor,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.all(12),
                  child: ListView.builder(
                    itemCount: attendees.length,
                    itemBuilder: (context, index) {
                      final attendee = attendees[index];
                      return ref.watch(getUserDataByIdProvider(attendee)).when(
                            data: (user) {
                              return ListTile(
                                title: Text(
                                  user!.name,
                                ),
                                leading: CircleAvatar(
                                  backgroundImage: (user.photoUrl != "")
                                      ? NetworkImage(user.photoUrl)
                                      : const AssetImage(
                                          IMAGE_PATH_DEFAULT_USER_PROFILE_IMAGE,
                                        ) as ImageProvider<Object>?,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Email: ${user.email}',
                                    ),
                                    Text(
                                      'Phone: ${user.campus}', // Add other details as needed
                                    ),
                                  ],
                                ),
                                trailing: const Icon(Icons
                                    .arrow_forward,), // Add a trailing icon as needed
                                onTap: () {
                                  // Add any action when the ListTile is tapped
                                },
                                // Add other details or customization as needed
                              );
                            },
                            error: (error, stackTrace) => ErrorText(
                              error: error.toString(),
                            ),
                            loading: () => const Loader(),
                          );
                    },
                  ),
                );
              }
            },
            error: (error, stackTrace) => ErrorText(
              error: error.toString(),
            ),
            loading: () => const Loader(),
          ),
    );
  }
}
