import 'package:e_complaint_box/screens/Complaint/feed/student/students_Filed.dart';
import 'package:e_complaint_box/screens/Complaint/feed/student/students_Resolved.dart';
import 'package:e_complaint_box/screens/about_us/about_us.dart';
import 'package:e_complaint_box/screens/about_us/contect_us.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:flutter/material.dart';

import 'MenuItem.dart';
import 'drawer_items.dart';
import '../../screens/authantication/students_login_Screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/profile/user_profile.dart';

class StudentDrawer extends StatefulWidget {
  const StudentDrawer({super.key});

  @override
  State<StudentDrawer> createState() => _StudentDrawerState();
}

class _StudentDrawerState extends State<StudentDrawer> {
  MenuItem currentItem = MenuItems.home;
  final zoomDrawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: ZoomDrawer(
        menuScreen: Builder(
          builder: (context) => DrawerItems(
              currentItem: currentItem,
              onSelectedItem: (item) {
                setState(() {
                  currentItem = item;
                  ZoomDrawer.of(context)!.close();
                });
              }),
        ),
        mainScreen: getScreen(),
        showShadow: true,
        openDragSensitivity: 700,
        closeDragSensitivity: 600,
        angle: 0,
        androidCloseOnBackTap: true,
        borderRadius: 24.0,
        controller: zoomDrawerController,
        slideWidth: MediaQuery.of(context).size.width * 0.70,
        menuScreenWidth: MediaQuery.of(context).size.width * 0.55,
        // clipMainScreen: true,
      ),
    );
  }

  Widget getScreen() {
    switch (currentItem) {
      case MenuItems.home:
        return const HomePage();
      case MenuItems.profile:
        return const MyProfileScreen();
      case MenuItems.my_complaints:
        return const Filed();
      case MenuItems.solved_complaints:
        return const Resolved();
      case MenuItems.contect_us:
        return const ContactUs();
      case MenuItems.about_us:
        return const AboutPage();
    }
    return const StudentLoginPage();
  }
}
