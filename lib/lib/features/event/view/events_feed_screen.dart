import 'package:as_central_desk/core/common/face_pile.dart';
import 'package:as_central_desk/features/event/controller/event_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/ui_constants.dart';
import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';
import '../../../core/common/search_text_field.dart';
import '../../../models/event.dart';
import '../../../routes/route_utils.dart';
import '../../../theme/theme.dart';
import '../widgets/event_card.dart';
import '../widgets/popular_events_card.dart';

class EventsFeedScreen extends ConsumerWidget {
  final bool backNavigationAllowed;
  const EventsFeedScreen({
    super.key,
    required this.backNavigationAllowed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Events',
          style: AppTextStyle.displayBlack.copyWith(
            color: AppColors.black,
          ),
        ),
        leading: backNavigationAllowed
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back_outlined,
                  color: AppColors.black,
                  size: 30,
                ),
                onPressed: () => Navigation.navigateToBack(context),
              )
            : null,
        backgroundColor: AppColors.scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: ref.watch(getAllEventsProvider).when(
            data: (events) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Join with\nupcoming events.',
                        style: AppTextStyle.textHeavy.copyWith(
                          color: AppColors.black,
                          fontSize: 26,
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      const SearchTextField(),
                      const SizedBox(
                        height: 18,
                      ),
                      Text(
                        'Popular',
                        style: AppTextStyle.textHeavy.copyWith(
                          color: AppColors.black,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height:
                            320, // Set a specific height that fits your design
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: events.length > 10 ? 10 : events.length,
                          itemBuilder: (BuildContext context, int index) {
                            List<Event> sortedEvents = [
                              ...events
                            ]; // Create a copy to avoid modifying the original list
                            sortedEvents.sort((a, b) => b.attendees.length
                                .compareTo(a.attendees
                                    .length)); // Sort by attendee count in descending order
                            Event event = sortedEvents[index];
                            return PopularEventsCard(event: event);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Text(
                        'All Events',
                        style: AppTextStyle.textHeavy.copyWith(
                          color: AppColors.black,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: events.length,
                        itemBuilder: (BuildContext context, int index) {
                          List<Event> sortedEvents = [
                            ...events
                          ]; // Create a copy to avoid modifying the original list
                          sortedEvents.sort((a, b) => b.postedAt.compareTo(a
                              .postedAt)); // Sort by postedAt in descending order
                          Event event = sortedEvents[index];
                          return EventCard(event: event);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
            error: (error, stackTrace) => ErrorText(
              error: error.toString(),
            ),
            loading: () => const Loader(),
          ),
    );
  }
}
