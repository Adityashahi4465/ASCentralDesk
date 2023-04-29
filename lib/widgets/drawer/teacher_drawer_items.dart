// ignore_for_file: use_build_context_synchronously

import 'package:e_complaint_box/widgets/drawer/teachers_MenuItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../global_widgets/loding_dialog.dart';
import '../../screens/splash.dart';

class TeachersMenuItems {
  static const home = TeacherMenuItem("Dashboard", Icons.home);
  static const new_notification =
      TeacherMenuItem("New Notification", Icons.notification_add);
  static const my_complaints =
      TeacherMenuItem("My Complaints", Icons.all_inbox);
  static const contect_us = TeacherMenuItem("Contact Us", Icons.contact_mail);
  static const about_us =
      TeacherMenuItem("About Us", Icons.accessibility_new_sharp);

  static const all = <TeacherMenuItem>[
    home,
    new_notification,
    my_complaints,
    contect_us,
    about_us,
  ];
}

class TeachersDrawerItems extends StatefulWidget {
  TeachersDrawerItems(
      {super.key, required this.currentItem, required this.onSelectedItem});
  // // late String level;
  // DrawerItems(@required this.name, @required this.proUrl, {super.key});
  final TeacherMenuItem currentItem;
  final ValueChanged<TeacherMenuItem> onSelectedItem;

  @override
  State<TeachersDrawerItems> createState() => _TeachersDrawerItemsState();
}

class _TeachersDrawerItemsState extends State<TeachersDrawerItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            ...TeachersMenuItems.all.map(buildMenuItem).toList(),
            const Spacer(
              flex: 2,
            ),
            ElevatedButton(
              onPressed: () async {
                const LoadingDialogWidget(
                  message: 'Signing Out',
                );
                try {
                  await FirebaseAuth.instance.signOut();
                
                  Fluttertoast.showToast(msg: "Signed Out successfully");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => const SplashScreen(),
                    ),
                  );
                } catch (e) {
                  Navigator.pop(context);
                  Fluttertoast.showToast(
                      msg: "Error Occurred: $e",
                      toastLength: Toast.LENGTH_LONG);
                }
              },
              child: const Text(
                'Sign Out',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(TeacherMenuItem item) => ListTile(
        selectedColor: Colors.indigo,
        selectedTileColor: Colors.white24,
        selected: widget.currentItem == item,
        minLeadingWidth: 20,
        leading: Icon(item.icon),
        title: Text(item.title),
        onTap: () => widget.onSelectedItem(item),
      );
}
