import 'package:e_complaint_box/screens/Complaint/feed/student/students_Filed.dart';
import 'package:e_complaint_box/screens/about_us/about_us.dart';
import 'package:e_complaint_box/screens/about_us/contect_us.dart';
import 'package:e_complaint_box/screens/notification/form/add_new_notification.dart';
import 'package:e_complaint_box/screens/profile/teacher_profile.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:flutter/material.dart';
import 'teacher_drawer_items.dart';
import 'teachers_MenuItem.dart';
import '../../screens/home/home_screen.dart';

class TeachersDrawer extends StatefulWidget {
  const TeachersDrawer({super.key});

  @override
  State<TeachersDrawer> createState() => _TeachersDrawerState();
}

class _TeachersDrawerState extends State<TeachersDrawer> {
  TeacherMenuItem currentItem = TeachersMenuItems.home;
  final zoomDrawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: ZoomDrawer(
        menuScreen: Builder(
          builder: (context) => TeachersDrawerItems(
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
      case TeachersMenuItems.home:
        return const HomePage();
      case TeachersMenuItems.new_notification:
        return const AddNewNotificationScreen();
      case TeachersMenuItems.my_complaints:
        return const Filed();
      case TeachersMenuItems.contect_us:
        return const ContactUs();
      case TeachersMenuItems.about_us:
        return const AboutPage();
    }
    return const HomePage();
  }
}
