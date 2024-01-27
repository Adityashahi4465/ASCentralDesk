import 'dart:convert';
import 'dart:ui';

import 'package:as_central_desk/constants/app_constant.dart';
import 'package:as_central_desk/core/common/face_pile.dart';
import 'package:as_central_desk/core/common/label_chip.dart';
import 'package:as_central_desk/core/common/rounded_button.dart';
import 'package:as_central_desk/core/core.dart';
import 'package:as_central_desk/core/utils/extensions/toggel_list_item.dart';
import 'package:as_central_desk/core/utils/snackbar.dart';
import 'package:as_central_desk/features/event/controller/event_controller.dart';
import 'package:as_central_desk/features/user/controller/user_controller.dart';
import 'package:as_central_desk/routes/route_utils.dart';
import 'package:as_central_desk/theme/app_colors.dart';
import 'package:as_central_desk/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';
import '../../../models/event.dart';
import '../../../models/user.dart';
import '../../auth/controller/auth_controller.dart';
import '../widgets/registration_dialog.dart';

class EventDetailsScreen extends ConsumerWidget {
  final String eventId;
  const EventDetailsScreen({
    Key? key,
    required this.eventId,
  }) : super(key: key);

  // void addRemoveBookmarks(
  //   WidgetRef ref,
  //   BuildContext context,
  //   User user,
  //   String eventId,
  // ) {
  // user.bookmarkedevents.toggle(eventId);

  //   ref.read(userControllerProvider.notifier).updateUser(
  //         user: user,
  //         context: context,
  //       );
  // }

  void registerEvent({
    required BuildContext context,
    required String userId,
    required Event event,
    required WidgetRef ref,
  }) {
    final updatedAttendees = [...event.attendees, userId];

    ref.read(eventControllerProvider.notifier).updateEvent(
          event: event.copyWith(
            attendees: updatedAttendees,
            capacity: event.capacity - 1,
          ),
          context: context,
        );
  }

  FutureVoid onRefresh(
    WidgetRef ref,
    String id,
  ) async {
    // ref.invalidate(
    //   getUserDataByIdProvider(uid),
    // );
    ref.invalidate(
      getEventByIdProvider(id),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final user = ref.watch(userProvider)!;
    final loading = ref.watch(eventControllerProvider);
    return ref.watch(getEventByIdProvider(eventId)).when(
          data: (event) {
            return Scaffold(
              body: SafeArea(
                child: LiquidPullToRefresh(
                  color: AppColors.lightPurpleColor,
                  height: 300,
                  backgroundColor: AppColors.white,
                  animSpeedFactor: 2,
                  showChildOpacityTransition: false,
                  onRefresh: () => onRefresh(
                    ref,
                    event!.id,
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image:
                            ExactAssetImage(IMAGE_PATH_DEFAULT_EVENT_THUMBNAIL),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.0)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 100,
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 80.0,
                                            height: 80.0,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: AppColors.subTitleColor
                                                  .withOpacity(0.4),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: IconButton(
                                                icon: const Icon(
                                                  Icons.arrow_back_ios,
                                                  color: AppColors.white,
                                                  size: 24,
                                                ),
                                                onPressed: () =>
                                                    Navigation.navigateToBack(
                                                        context),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Event Details',
                                            style:
                                                AppTextStyle.textHeavy.copyWith(
                                              color: AppColors.white,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Container(
                                            width: 80.0,
                                            height: 80.0,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: AppColors.subTitleColor
                                                  .withOpacity(0.4),
                                              shape: BoxShape.circle,
                                            ),
                                            child: IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.bookmark_outline,
                                                color: AppColors.white,
                                                size: 24,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //////////////////////////////////////////////////////////         BODY         ///////////////////////////////
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 244, 244, 244),
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20.0)),
                                  ),
                                  child: SingleChildScrollView(
                                    physics: const ClampingScrollPhysics(),
                                    child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  event!.title,
                                                  style: AppTextStyle.textHeavy
                                                      .copyWith(
                                                    color: AppColors.black,
                                                    fontSize: 32,
                                                  ),
                                                ),
                                              ),
                                              FacePile(
                                                profileImages: event.attendees
                                                    .map<String>((userId) {
                                                  return ref
                                                      .watch(
                                                          getUserDataByIdProvider(
                                                              userId))
                                                      .when(
                                                        data: (user) =>
                                                            user!.photoUrl,
                                                        error: (error,
                                                                stackTrace) =>
                                                            '',
                                                        loading: () => '',
                                                      );
                                                }).toList(),
                                              )
                                            ],
                                          ),
                                          Text(
                                            event.subtitle,
                                            style: AppTextStyle.displayBold
                                                .copyWith(
                                              color: AppColors.subTitleColor,
                                              fontSize: 16,
                                              letterSpacing: 1.5,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            event.eventType,
                                            style: AppTextStyle.displayBold
                                                .copyWith(
                                              color: AppColors.black,
                                              fontSize: 14,
                                              letterSpacing: 2,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .attach_money_rounded,
                                                        color: AppColors.green,
                                                        size: 24,
                                                      ),
                                                      const SizedBox(
                                                        width: 12,
                                                      ),
                                                      Text(
                                                        event.prize.toString(),
                                                        style: AppTextStyle
                                                            .textRegular
                                                            .copyWith(
                                                          fontSize: 16,
                                                          color:
                                                              AppColors.green,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.groups_2_sharp,
                                                        color: AppColors.red,
                                                        size: 24,
                                                      ),
                                                      const SizedBox(
                                                        width: 12,
                                                      ),
                                                      Text(
                                                        'Hurry! only ${event.capacity.toString()} slots left',
                                                        style: AppTextStyle
                                                            .textRegular
                                                            .copyWith(
                                                          fontSize: 16,
                                                          color: AppColors.red,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.location_on,
                                                        color:
                                                            AppColors.primary,
                                                        size: 24,
                                                      ),
                                                      const SizedBox(
                                                        width: 12,
                                                      ),
                                                      Text(
                                                        '${event.location}, ${event.venueType}',
                                                        style: AppTextStyle
                                                            .textRegular
                                                            .copyWith(
                                                          fontSize: 16,
                                                          color:
                                                              AppColors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.access_time,
                                                        color:
                                                            AppColors.primary,
                                                        size: 24,
                                                      ),
                                                      const SizedBox(
                                                        width: 12,
                                                      ),
                                                      Text(
                                                        DateFormat(
                                                                'd MMM yyyy hh:mm a')
                                                            .format(
                                                          event.startDate,
                                                        ),
                                                        style: AppTextStyle
                                                            .textRegular
                                                            .copyWith(
                                                          fontSize: 16,
                                                          color:
                                                              AppColors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                            'About Event',
                                            style:
                                                AppTextStyle.textBold.copyWith(
                                              fontSize: 18,
                                              color: AppColors.black,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                            event.description,
                                            style: AppTextStyle.displayRegular
                                                .copyWith(
                                              fontSize: 12,
                                              color: AppColors.black,
                                              letterSpacing: 1.5,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10.0,
                                            ),
                                            child: Container(
                                              width: double.maxFinite,
                                              decoration: BoxDecoration(
                                                color: AppColors
                                                    .lightShadowColor
                                                    .withOpacity(0.6),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Start',
                                                          style: AppTextStyle
                                                              .displayLight
                                                              .copyWith(
                                                            color:
                                                                AppColors.black,
                                                            fontSize: 14,
                                                            letterSpacing: 3,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        Text(
                                                          DateFormat(
                                                                  'd MMM yyyy hh:mm a')
                                                              .format(
                                                            event.startDate,
                                                          ),
                                                          style: AppTextStyle
                                                              .textBold
                                                              .copyWith(
                                                            color:
                                                                AppColors.black,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text(
                                                          'End',
                                                          style: AppTextStyle
                                                              .displayLight
                                                              .copyWith(
                                                            color:
                                                                AppColors.black,
                                                            fontSize: 14,
                                                            letterSpacing: 3,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        Text(
                                                          DateFormat(
                                                                  'd MMM yyyy hh:mm a')
                                                              .format(
                                                            event.endDate,
                                                          ),
                                                          style: AppTextStyle
                                                              .textHeavy
                                                              .copyWith(
                                                            color:
                                                                AppColors.black,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Organizer Info.',
                                            style:
                                                AppTextStyle.textBold.copyWith(
                                              fontSize: 18,
                                              color: AppColors.black,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            '${event.organizerInfo},\n${event.campus} ',
                                            style: AppTextStyle.displayRegular
                                                .copyWith(
                                              fontSize: 12,
                                              color: AppColors.black,
                                              letterSpacing: 1.5,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Text(
                                            'Registration Criteria',
                                            style:
                                                AppTextStyle.textBold.copyWith(
                                              fontSize: 18,
                                              color: AppColors.black,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            '${event.criteria} ',
                                            style: AppTextStyle.displayRegular
                                                .copyWith(
                                              fontSize: 12,
                                              color: AppColors.black,
                                              letterSpacing: 1.5,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          SizedBox(
                                            height: 250,
                                            child: PageView.builder(
                                              itemCount:
                                                  event.eventImages.length,
                                              itemBuilder: (context, index) =>
                                                  Image.network(
                                                event.eventImages[index],
                                                width: double.maxFinite,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 14,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              floatingActionButton: RoundedButton(
                onPressed: () {
                  event.admins.contains(user.uid)
                      ? Navigation.navigateToEventRegistrationsScreen(
                          context,
                          eventId,
                        )
                      : event.attendees.contains(user.uid)
                          ? showCustomSnackbar(
                              context,
                              'You\'ve already registered for this event!',
                            )
                          : event.capacity <= 0
                              ? showCustomSnackbar(
                                  context,
                                  "Oops! Looks like you just missed a spot. This event is at full capacity.",
                                )
                              : showDialog(
                                  context: context,
                                  builder: (context) => Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      loading
                                          ? const Loader()
                                          : RegistrationDialog(
                                              onRegisterPressed: () {
                                                registerEvent(
                                                  context: context,
                                                  event: event,
                                                  userId: user.uid,
                                                  ref: ref,
                                                );
                                                Navigator.pop(
                                                    context); // Close the dialog
                                              },
                                            ),
                                    ],
                                  ),
                                );
                },
                text: event.admins.contains(user.uid)
                    ? 'See Registrations'
                    : event.attendees.contains(user.uid)
                        ? 'Already Registered!'
                        : event.capacity <= 0
                            ? "Sorry! No more slots available."
                            : 'Register',
                linearGradient: AppColors.redGradient,
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            );
          },
          error: (error, stackTrace) => ErrorText(
            error: error.toString(),
          ),
          loading: () => const Loader(),
        );
  }
}
