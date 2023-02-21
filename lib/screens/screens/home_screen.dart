import 'package:e_complaint_box/global/global.dart';
import 'package:e_complaint_box/screens/Complaint/students_Filed.dart';
import 'package:e_complaint_box/screens/feed.dart';
import 'package:e_complaint_box/screens/teacher_profile.dart';
import 'package:e_complaint_box/screens/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../widgets/home_icon_buttons.dart';
import 'Complaint/Compose.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? name = sharedPreferences!.getString('name') ?? 'Unknown';
  String? type = sharedPreferences!.getString('type') ?? 'Unknown';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF363567),
      body: Column(
        children: [
          Stack(
            children: [
              Transform.rotate(
                origin: const Offset(30, -65),
                angle: 2.4,
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 70,
                    top: 40,
                  ),
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                    gradient: const LinearGradient(
                      begin: Alignment.bottomLeft,
                      colors: [Color(0xffFD8BAB), Color(0xFFFD44C4)],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'E-ASComplaints',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Hello $name👋!!!\nWelcome to DSEU E-Complaint Box',
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CatigoryW(
                                  image: 'assets/images/feed_Icon.jpg',
                                  text: 'Feed',
                                  color: const Color(0xFF47B4FF),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                const Feed()));
                                  }),
                              CatigoryW(
                                  image: 'assets/images/my_complaint_icon.png',
                                  text: 'My Complaints',
                                  color: const Color(0xFFA885FF),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                const Filed()));
                                  })
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CatigoryW(
                                  image: 'assets/images/new_complaint.png',
                                  text: 'File Complaint',
                                  color: const Color(0xFF7DA4FF),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                const Compose()));
                                  }),
                              CatigoryW(
                                  image: 'assets/images/profile-icon.png',
                                  text: 'My Profile',
                                  color: const Color(0xFF43DC64),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                (type == 'admin')
                                                    ? TeacherProfile()
                                                    : const MyProfileScreen()));
                                  })
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/* */
