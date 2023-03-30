// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harvestx/core/common/background.dart';

import '../../../../../core/common/alert_dialog.dart';

List<String> label = [
  'my store',
  'orders',
  'edit profile',
  'manage product',
  'balance',
  'statics',
];
List<IconData> icons = [
  Icons.store,
  Icons.shop_2_outlined,
  Icons.edit,
  Icons.settings,
  Icons.attach_money,
  Icons.show_chart,
];
List<String> pages = [
  '/my_store',
  '/supplier_orders',
  '/edit_business',
  '/manage_products',
  'supplier_balance',
  '/supplier_statics',
];

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Dashboard',
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              MyAlertDialog.showMyDialog(
                context: context,
                title: 'Log Out',
                content: 'Are you sure to log out ?',
                tabNo: () => Navigator.pop(context),
                tabYes: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/login_screen');
                },
              );
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
           BackgroundImage(),
          Padding(
            padding: const EdgeInsets.all(25),
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 40,
              crossAxisSpacing: 40,
              children: List.generate(6, (index) {
                return InkWell(
                  onTap: () => Navigator.pushNamed(context, pages[index]),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(173, 26, 150, 92),
                        borderRadius: BorderRadius.circular(12),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Color.fromARGB(255, 215, 234, 198),
                        //     offset: const Offset(4, 4),
                        //     blurRadius: 15,
                        //     spreadRadius: 2,
                        //   ),
                        //   const BoxShadow(
                        //     color: Colors.white,
                        //     offset: Offset(-4, -4),
                        //     blurRadius: 15,
                        //     spreadRadius: 1,
                        //   ),
                        // ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            icons[index],
                            color: const Color.fromARGB(255, 224, 234, 197),
                            size: 50,
                          ),
                          Text(
                            label[index].toUpperCase(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunitoSans(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 224, 234, 197),
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      )),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
