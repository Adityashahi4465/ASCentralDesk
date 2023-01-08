import 'package:e_complaint_box/global/global.dart';
import 'package:e_complaint_box/global_widgets/loding_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../screens/authantication/students_login_Screen.dart';
import 'MenuItem.dart';

class MenuItems {
  static const home = MenuItem("Home", Icons.home);
  static const profile = MenuItem("Profile", Icons.person);
  static const my_complaints = MenuItem("My Complaints", Icons.all_inbox);
  static const solved_complaints =
      MenuItem("Solved Complaints", Icons.all_inbox);
  static const contect_us = MenuItem("Contact Us", Icons.contact_mail);
  static const about_us = MenuItem("About Us", Icons.accessibility_new_sharp);

  static const all = <MenuItem>[
    home,
    profile,
    my_complaints,
    solved_complaints,
    contect_us,
    about_us,
  ];
}

class DrawerItems extends StatefulWidget {
  DrawerItems(
      {super.key, required this.currentItem, required this.onSelectedItem});
  // // late String level;
  // DrawerItems(@required this.name, @required this.proUrl, {super.key});
  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;

  @override
  State<DrawerItems> createState() => _DrawerItemsState();
}

class _DrawerItemsState extends State<DrawerItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Spacer(),
            ...MenuItems.all.map(buildMenuItem).toList(),
            Spacer(
              flex: 2,
            ),
            ElevatedButton(
              onPressed: () {
                const LoadingDialogWidget(
                  message: 'Signing Out',
                );
                try {
                  FirebaseAuth.instance.signOut();
                  Fluttertoast.showToast(msg: "Signed Out successfully");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => const StudentLoginPage(),
                    ),
                  );
                } catch (e) {
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

  Widget buildMenuItem(MenuItem item) => ListTile(
        selectedColor: Colors.indigo,
        selectedTileColor: Colors.white24,
        selected: widget.currentItem == item,
        minLeadingWidth: 20,
        leading: Icon(item.icon),
        title: Text(item.title),
        onTap: () => widget.onSelectedItem(item),
      );
}
