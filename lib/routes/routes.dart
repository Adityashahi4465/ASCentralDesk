import 'package:as_central_desk/features/auth/views/auth_screen.dart';
import 'package:as_central_desk/features/auth/views/verify_email_screen.dart';
import 'package:as_central_desk/features/complaint/view/complaint_details_screen.dart';
import 'package:as_central_desk/features/equipments/view/new_equipment_form_screen.dart';
import 'package:as_central_desk/features/event/view/event_details_screen.dart';
import 'package:as_central_desk/features/event/view/event_registerations.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

import '../features/complaint/view/new_complaint_add_screen.dart';
import '../features/event/view/new_event_form_screen.dart';
import '../features/home/views/home_screen.dart';
import '../features/notice/view/new_notice_screen.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (route) => const MaterialPage(
        child: AuthScreen(),
      ),
  '/verify-email': (route) => const MaterialPage(
        child: VerifyEmailScreen(),
      ),
});
final loggedInRoute = RouteMap(routes: {
  '/': (route) => const MaterialPage(
        child: HomeScreen(),
      ),
  '/new-complaint': (route) => const MaterialPage(
        child: NewComplaintFormScreen(),
      ),
  '/new-event': (route) => const MaterialPage(
        child: NewEventFormScreen(),
      ),
  '/new-notice': (route) => const MaterialPage(
        child: NewNoticeFormScreen(),
      ),
  '/new-equipment': (route) => const MaterialPage(
        child: NewEquipmentFormScreen(),
      ),
  '/complaint/:complaintId': (routeData) {
    final complaintId = routeData.pathParameters['complaintId']!;
    return MaterialPage(
        child: ComplaintDetailsScreen(complaintId: complaintId));
  },
  '/event/:eventId': (routeData) {
    final eventId = routeData.pathParameters['eventId']!;
    return MaterialPage(
      child: EventDetailsScreen(
        eventId: eventId,
      ),
    );
  },
  '/event-registrations/:eventId': (routeData) {
    final eventId = routeData.pathParameters['eventId']!;
    return MaterialPage(
      child: EventRegistrationsScreen(
        eventId: eventId,
      ),
    );
  },
});
