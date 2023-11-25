import 'package:as_central_desk/apis/cloudinary_api.dart';
import 'package:as_central_desk/apis/event_api.dart';
import 'package:as_central_desk/constants/ui_constants.dart';
import 'package:as_central_desk/core/enums/enums.dart';
import 'package:as_central_desk/features/auth/controller/auth_controller.dart';
import 'package:as_central_desk/models/event.dart';
import 'package:as_central_desk/routes/route_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/snackbar.dart';

final eventControllerProvider = StateNotifierProvider<EventController, bool>(
  (ref) => EventController(
    eventAPI: ref.watch(eventApiProvider),
    ref: ref,
  ),
);

// final getEventByIdProvider =
//     FutureProvider.family((ref, String eventId) {
//   final eventController = ref.watch(eventControllerProvider.notifier);
//   return eventController.getEventById(eventId: eventId);
// });

// final getAllEventsProvider = FutureProvider<List<event>>((ref) async {
//   // Assuming you have a function named getAllEvents in your controller
//   final controller = eventController(
//     eventAPI: ref.read(eventApiProvider),
//     ref: ref,
//   );
//   return controller.getAllEvents();
// });

// final getBookmarkedEventsProvider =
//     FutureProvider<List<event>>((ref) async {
//   // Assuming you have a function named getAllEvents in your controller
//   final controller = eventController(
//     eventAPI: ref.read(eventApiProvider),
//     ref: ref,
//   );
//   return controller.getBookmarkedEvents();
// });

class EventController extends StateNotifier<bool> {
  final EventAPI _eventAPI;
  final Ref _ref;
  EventController({required EventAPI eventAPI, required Ref ref})
      : _eventAPI = eventAPI,
        _ref = ref,
        super(false); // loading while asynchronous tasks initially false

  void saveEventToDatabase({
    required String title,
    required String subtitle,
    required String description,
    required String criteria,
    required String campus,
    required String venueType,
    required DateTime startDate,
    required DateTime endDate,
    required int capacity,
    required List<dynamic> eventImages,
    required String organizerInfo,
    required String registrationLink,
    required String contactInfo,
    required String eventType,
    required String location,
    required int prize,
    required BuildContext context,
  }) async {
    state = true;

    // Upload Images

    List<String> images = [];

    // Check the platform and handle image data accordingly
    if (kIsWeb) {
      // For web, use image bytes
      final res = await _ref.read(cloudinaryApiProvider).uploadMultipleImages(
            images: eventImages.cast<List<int>>(),
            folder: "event_images",
          );
      res.fold((l) {
        showCustomSnackbar(context, l.message);
        state = false;
      }, (r) => images = r);
    } else {
      // For other platforms (Android, iOS), use file paths
      final res = await _ref.read(cloudinaryApiProvider).uploadMultipleImages(
            images: eventImages.cast<String>(),
            folder: "event_images",
          );
      res.fold(
        (l) {
          showCustomSnackbar(context, l.message);
          state = false;
        },
        (r) => images = r,
      );
    }
    final event = Event(
      id: '',
      title: title,
      subtitle: subtitle,
      description: description,
      campus: campus,
      postedAt: DateTime.now(),
      venueType: venueType,
      startDate: startDate,
      endDate: endDate,
      tags: [],
      capacity: capacity,
      eventImages: images,
      organizerInfo: organizerInfo,
      attendees: [],
      registrationLink: registrationLink,
      contactInfo: contactInfo,
      eventType: eventType,
      location: location,
      feedback: [],
      criteria: criteria,
      prize: prize,
    );
    final res = await _eventAPI.saveEventToDatabase(
      event: event,
    );
    state = false;
    res.fold(
      (l) {
        print(l.message);
        showCustomSnackbar(context, l.message);
      },
      (user) {
        showCustomSnackbar(context, "event Filed Successfully");
        Navigation.navigateToBack(context);
      },
    );
  }

  // Future<void> updateevent({
  //   required Event event,
  //   required BuildContext context,
  // }) async {
  //   final res = await _eventAPI.updateevent(
  //     event: event,
  //   );
  //   res.fold((l) => showCustomSnackbar(context, l.message), (r) {
  //     _ref.invalidate(getAlleventsProvider);
  //     _ref.invalidate(geteventByIdProvider);
  //   });
  // }

  // Future<List<event>> getAllevents() async {
  //   final res = await _ref.read(eventApiProvider).getAllevents();
  //   List<event> events = [];

  //   res.fold(
  //     (failure) {
  //       events = [];
  //     },
  //     (eventList) {
  //       events = eventList;
  //     },
  //   );

  //   return events;
  // }

  // Future<List<event>> getBookmarkedevents() async {
  //   final uid = _ref.read(userProvider)!.uid;
  //   final res = await _ref.read(eventApiProvider).getBookmarkedevents(uid: uid);
  //   List<event> events = [];

  //   res.fold(
  //     (failure) {
  //       events = [];
  //     },
  //     (eventList) {
  //       events = eventList;
  //     },
  //   );

  //   return events;
  // }

  // Future<event?> geteventById({required String eventId}) async {
  //   final res = await _eventAPI.geteventById(eventId: eventId);
  //   return res.fold((l) => null, (r) => r);
  // }
}
