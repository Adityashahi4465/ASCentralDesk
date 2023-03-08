import 'package:e_complaint_box/screens/Complaint/feed/complaints_feed.dart';
import 'package:e_complaint_box/screens/notification/feed/events_feed.dart';
import 'package:e_complaint_box/screens/notification/feed/notification_feed.dart';
import 'package:flutter/material.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({super.key});

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  int _selectedIndex = 0;

  final List _tabs = [
    const NotificationFeedScreen(),
    const ComplaintFeedScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Color.fromARGB(255, 22, 33, 98),
        selectedIconTheme: IconThemeData(
          color: const Color(0xFF181D3D),
        ),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        unselectedItemColor: Color.fromARGB(255, 25, 59, 96),
        elevation: 0,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.comment_bank_rounded),
            label: 'Complaints',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
