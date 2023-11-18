import 'package:as_central_desk/constants/app_constant.dart';
import 'package:as_central_desk/features/complaint/view/feeds/all_complaints_feed.dart';
import 'package:as_central_desk/features/complaint/view/feeds/my_complaints_feed.dart';
import 'package:as_central_desk/features/dashboard/view/dashboard_screen.dart';
import 'package:as_central_desk/features/event/view/events_feed_screen.dart';
import 'package:as_central_desk/features/notice/view/notice_feed_screen.dart';
import 'package:flutter/material.dart';

import '../features/complaint/view/complaints_feed_screen.dart';
import '../features/profile/view/profile_screen.dart';

class UiConstants {
  static List<Widget> homeTabWidgets = [
    DashboardScreen(),
    const ComplaintsFeedScreen(),
    const EventsFeedScreen(),
    const NoticeFeedScreen(),
    const ProfileScreen(),
  ];
  static List<Widget> complaintFeeds = [
    const AllComplaintsFeed(),
    const MyComplaintsFeed(),
  ];

  static const List<IconData> studentsFABIconsList = [
    Icons.add_chart_outlined,
    Icons.forward_to_inbox_outlined,
    Icons.toys_outlined,
  ];

  static List adminFABIconsList = [
    IMAGE_PATH_ADD_COMPLAINT,
    IMAGE_PATH_ADD_EVENT,
    IMAGE_PATH_ADD_NOTICE,
    IMAGE_PATH_ADD_SPORTS,
    Icons.add,
  ];

  static const List<String> complaintCategories = [
    'Academic Issues',
    'Administrative Issues',
    'Infrastructure Issues',
    'IT and Technical Issues',
    'Social and Campus Life',
    'Security Concerns',
    'Health and Wellness',
    'Transportation Issues',
    'Diversity and Inclusion',
    'Miscellaneous',
  ];
}
