import 'package:as_central_desk/features/dashboard/view/dashboard_screen.dart';
import 'package:flutter/material.dart';

import '../features/complaint/view/complaints_feed_screen.dart';
import '../features/events_and_notices/view/events_and_notices_screen.dart';
import '../features/profile/roles/student_profile_screen.dart';

class UiConstants {
  static List<Widget> homeTabWidgets = [
    DashboardScreen(),
    const ComplaintsFeedScreen(),
    const EventsAndNoticesScreen(),
    const ProfileScreen(),
  ];

  final List<IconData> studentsFABIconsList = [
    Icons.add_chart_outlined,
    Icons.forward_to_inbox_outlined,
    Icons.toys_outlined,
  ];

  final List<IconData> adminFABIconsList = [
    Icons.add_chart_outlined,
    Icons.post_add_outlined,
    Icons.note_add_rounded,
    Icons.forward_to_inbox_outlined,
    Icons.add_chart_outlined,
  ];
}
