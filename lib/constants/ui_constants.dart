import 'package:as_central_desk/constants/app_constant.dart';
import 'package:as_central_desk/features/dashboard/view/dashboard_screen.dart';
import 'package:as_central_desk/features/event/view/events_feed_screen.dart';
import 'package:as_central_desk/features/notice/view/notice_feed_screen.dart';
import 'package:flutter/material.dart';

import '../features/complaint/view/complaints_feed_screen.dart';
import '../features/profile/roles/student_profile_screen.dart';

class UiConstants {
  static List<Widget> homeTabWidgets = [
    DashboardScreen(),
    const ComplaintsFeedScreen(),
    const EventsFeedScreen(),
    const NoticeFeedScreen(),
    const ProfileScreen(),
  ];

  static const List<IconData> studentsFABIconsList = [
    Icons.add_chart_outlined,
    Icons.forward_to_inbox_outlined,
    Icons.toys_outlined,
  ];

  static  List<Map<String, dynamic>> adminFABIconsList = [
    {
      'image': IMAGE_PATH_ADD_COMPLAINT,
      'onPressed': () {
        // onPressed action for add complaint
        print('Add Complaint pressed!');
      },
    },
    {
      'image': IMAGE_PATH_ADD_EVENT,
      'onPressed': () {
        // onPressed action for add event
        print('Add Event pressed!');
      },
    },
    {
      'image': IMAGE_PATH_ADD_NOTICE,
      'onPressed': () {
        // onPressed action for add notice
        print('Add Notice pressed!');
      },
    },
    {
      'image': IMAGE_PATH_ADD_SPORTS,
      'onPressed': () {
        // onPressed action for add sports
        print('Add Sports pressed!');
      },
    },
  ];
}
